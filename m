Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDE93D1CCA
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790722785; cv=none; b=fRZjuYM3UOGA9XVvbWgHa3mTdUIjdJW1EFBYLrbB87KjsN+Y4N+TACK7DMMRksClfBS8D1oQj7pLU5+p85UUFxVKsLZ9BL6vLMPnrtzTBP5Q6J1ewq51EFRSyvw3ahbR/dLLqISYdMal07xzsXdAJ5BygTdUf9BSzUQAt519M8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790722785; c=relaxed/simple;
	bh=yciXXgFMGDVOMZPQ+5IrugMojC+KS2xZdRYXVl6T17Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBRFAljFq2E3BSwkvrwnAuGAJ7PSPcs5Q0GLDZ/Rgch+RUy79nHx1Rn7jfaspd0fkxB+APdLMdFymBO11U+w/KIc8mnrR3fdNeqvFlEiJTrloZxXdND9noqkijUijiCVXhp6KX9tp+lIZYWPCLofSuxG5/NnzVYqVooIdCE3/0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcTI2Fci; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcTI2Fci"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3931so35625185e9.3
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 15:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790722782; x=1791327582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Gv+PysJI6ddPMh+/2D1kK5GEPdkeF2uLZFjE2FJN3E=;
        b=EcTI2FcitOqfphbCCL7eny8bTwBNKzWtYEszT0bkwhgIHJ1SzSNyf2t8xOg/lp8A3+
         +w5Y640OqMdr3dy1rmVWHd9a/0P9d96H7aln+BuA++Ntuj3yF/8hJQUpdIGZFJB+VWdF
         BR5D+sboZ2cQIK6GLFQRP4dHmE1CLdnqAA3MRxkmMCGWHaempFsFKYTc4VwzyXwbwaQ8
         nVXBahy3dXLG/7G/+Dbw50YwhCoTImDlv/sBu1xpVlQRPGSuuHCd+jPf8W3mJ5yhXsKu
         xxH1W6SFPgq1b+VHd34+EZkZzlWhMX5Nn8fXvXEqLDcUWojQD3BkGZTdb5IAf/x2DZHV
         hVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790722782; x=1791327582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Gv+PysJI6ddPMh+/2D1kK5GEPdkeF2uLZFjE2FJN3E=;
        b=Zi9/Y9VJrMoSwsvbPqBD8lIUl+80/Go+HOPH8UGyo1l3dysTuy7VhS0U8/x54YNVrB
         +4jRz1+TeFTqU1ZEZ3SLlyTXnv1eALOccloesGN5VOsSdoJ6S9Pn0KOgXXUi6vQ6ymGi
         U/yLQHqB7l0CZEpy3W56viQunWiew6uo32fCym6A+bmCl1EXKZ46jLexvTNczOii9cvS
         aft5AeRs1uMv+F7d2cdX1Ckv9opsZeYvOS23yiu/owNVguB8sUYfse3AKTr6/v+9gl06
         yBG7t/JS/xBLhQf303THAXNyyE4lKmaurr3sSfBHMDStwj5s3UioDgVfyxtFNdw/mB7E
         0B2w==
X-Forwarded-Encrypted: i=1; AKwUvBxhzFwjcjVPPyU2SudBHMc5Ah4bnmMusijwfEJWxhCU1J5JF1OGO6HopF3bt0LMgp+n1nssZ60=@vger.kernel.org
X-Gm-Message-State: AFuF++lpufsjQBabHA2OIzhYSDRNfVoxwk5gYDtL8uFWI8byvgAk3Kvy
	BAg8AlfCWwwAgLL86APbb0NCJJOeOaMCqcFyJhy06pZh6FGAF+3fkoFC
X-Gm-Gg: AYBFou3hSniV6OaA7GRRKXGOdW35ijyrbYp48PeSaE/4j4f/o1tnE5Q/5MBo4eKleX8
	rw5CH7+t/HkdLTPUXldw0cgvZemSX2oZsWsuRXT2eq3o/aw51V8RAiViyNH/cNA2vh1hsPM8mR9
	vwITJ6XqdUSB4k0a5Cf3SNc2jQnAkdiSR+jhb6mD0VOHWfGx5bJXGMcUj6Fh4V2vdJTQHF4Go2k
	1R0h0eI7aURaMpFr/ngJ8W8tOmBSHhpX2nNedXqZmAAa73nyWWKm+VsD8Yzi3SGjCm+sb/nk45m
	JWCrr86MzLHVKGNDtB5YMTdhnqpdkF0xqL1V+9yXBRRvhdbgrmXczerLY4EKmHW7zFMZdafsg5u
	XFkvHZu7j0atab3AUQFHmQA+g+La4NPxkem027Kg5IU/KB4qLxTuG2kCBBFHq5jo3eoFrNc8nO+
	HzEsnR8Q2hBYGcDgvzXwJYVCcj+AQpHhOB7NlmWmD8do5uU0M5pIUE3ifQV6DZhx4y7WD4Rh5EG
	KtuKEb5e1jPpydg3gfWL+pt54xpf+qNtqjZiYhyFltP
X-Received: by 2002:a05:600c:8b38:b0:49f:fd4c:cccd with SMTP id 5b1f17b1804b1-4a015146b71mr8103765e9.28.1790722782234;
        Tue, 29 Sep 2026 15:59:42 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.116.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0174e161bsm2551225e9.5.2026.09.29.15.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 15:59:41 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] rtnetlink: wait for RCU readers in rtnl_link_unregister()
Date: Wed, 30 Sep 2026 00:59:30 +0200
Message-ID: <20260929225932.349581-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAL4WiioFMQN4troVjQjCmE6Z9kwwb95SnoEupjD=PPSK6Q5f6w@mail.gmail.com>
References: <20260929170444.218093-1-parri.andrea@gmail.com> <CAL4WiioFMQN4troVjQjCmE6Z9kwwb95SnoEupjD=PPSK6Q5f6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Sep 29, 2026 at 08:01:39PM +0200, Eric Dumazet wrote:
> Patch looks good, but I would probably add a comment here, because all
> these barriers without comments
> are a pain.
>
> /* Wait for rtnl_link_ops_get() readers that found ops but have not
> yet taken ops->srcu. */
> > +       synchronize_rcu();

Will do in v2, thanks.


> Adding comments for the other barriers in a future followup would be awesome.

Sure.  I have a net-next patch ready which comments the remaining waits
in net/core/rtnetlink.c: synchronize_rcu() in rtnl_af_unregister(), the
synchronize_srcu() calls in rtnl_link_unregister() and
rtnl_af_unregister(), and synchronize_net() in rtnl_unregister_all().
I'll send it once this fix reaches net-next, unless you meant a wider
scope than this file.


> Reviewed-by: Eric Dumazet <edumazet@kernel.org>

Thanks for the review,
  Andrea
