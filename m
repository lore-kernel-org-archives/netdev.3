Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FACE5013B6
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 23:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377933; cv=none; b=KTv3k7EfoVeevm0aiqPTbYwFbYYKY7g58HVHqND4MOMrrILAm3s+0WwY4AMyt2Zw+1vd2J9IddHP2mZNRrV5EFSlPkz47DDLtYKa7FmJKanYnBxG8TDwP0MgBhUtNPYlcqlpTW8SBx4oWRxmTsLhS20OwwESeGFPDcjrFzoVjsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377933; c=relaxed/simple;
	bh=ybLOr3FDsnQoXtU2ro+MWcF8GTD8LhmOFxqQajcdAWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvZA05bHMdcV9AtQMEf5sdkm/9U6RFD+bfEYIkag2bAP6eeyJwWxsqsd+7C+ZXWXf+/XB9rpt1jOL0FbLvl9NsGfnlhs3F+Gw2jIVNMAvyry6oN5iaJaPMXATPRrXeTrCoityhOqGl/HzLrWHCRRtEGCFHOTIn6ktmNAgeAWBXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=szy08CW6; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szy08CW6"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8ecca9f3fso706773e87.2
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 16:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790377930; x=1790982730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=idOZhCq94Yr7EO3Y+X4S5dviexgS4OYmWui9ECgBH9A=;
        b=szy08CW6yKeB21967SGp/T+RSjHck1bPczC+mzEM/MwikhpcW8cKgEzMTpAO0h6Z9e
         qVFzwWTq2Awyn/WxKXTuCZY15QtfC4BuuiL84yXoHWokAf26UUFDBzMWKh+HB3+rohO9
         nbjkefucyc0XqfJdEUCqG9Q/xT+xA2wrzSdJ7A9C5iSeyKHrVn8Ly/xn3GE798hbOXX9
         a1LLmGFHszjk5mRUg9hZdWaves7fkjJob2darHEpirhh+kFlSONWg6CiNgZPnUiDiBSh
         oV33KCOPRLo+LJFy6tSPpoSDIJfTgQ0N06ZdtBYibBJHFJq+qhebcpb4hjp0J/pfdMW+
         GO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790377930; x=1790982730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=idOZhCq94Yr7EO3Y+X4S5dviexgS4OYmWui9ECgBH9A=;
        b=bvJtPqGOXUzcu4roh6clcts13csEfEwlnt0N1RN2XCKofsPsi4lcUgj9sy3yZkPioC
         0ErEcJUe4+EWgE/Q3jPzcEpwobnxpRDxdImWMP3Cc/bvF+IecYkKSBFp4YqEDGf/MjC3
         yMkhroNlJtFSiJHOzc7JEiffMeItltYWSfgy0L7R6ioj4PUW/dzyMNCAFiIYzvWuRKPj
         XqF6Q+kqVKTJsUJyz2HaRGObdGuIQaB/MdAla2J04w3CUyibsuecJwLJkLw99NrjIo2L
         QZ2UcEtfhx4jjYLj0VmrPJyvAFCU7rXX1TtP0mkyVLbRwVCQh9B9qYHsyQhr1o9FV7UM
         5eWQ==
X-Gm-Message-State: AFuF++lpkr/+KrtrUjojRZGIRj0QJS8ha22cqeAp310K5dju7LxcLK/5
	D58pONHmUKB1I/ko8plvxkb125ORrGTVr/druYvnsMH62xTXI2jhkO7R
X-Gm-Gg: AYBFou0I+cF14AY2EediGEE8CHhiHbLBZlzc4HsmvAqTJkWavIRoL7lxeqZRXK9CJKD
	3idM771F5ZaH/4lf3lvXi4a0y5MXaL5AgerSgs4VgNbSzY7vsnkRFP/b9hbz3gQfaWB+BYbYOr3
	uWSZD4KCd4SBb9qBc+zSLwFV1ZFnBHIWBwNVCCpc8Sr+tP+neQtHuV2kl5iJQn/BZBolByIPF7q
	3tTLe3Xe6qLM3VKhh4F4FXsAxY0Nr14Qz2bTpCbRlQjhHPOe3Y/NKq/JbmXCGlDU9VZu5c1us9o
	yf9Wmz2M2EAFeGUngRSFjYPnJs9zWmDnxQyyUWNFIUcy40pHxFUmlJdRYOxr/brILTvrZd+92jK
	dsvi2wx6ZPa+i9QXWgk2z9l9bpbazo88IRCkvF3ljPuRfzcgQJxdannIw0ABhRPsdDAz0GRYz26
	KCsfMvzzmq7GP5Bvx3U7bAzM5R6lXztzPVOdNJXsNJA3NO8SnAlWb0VPadqBunPpMnoh7CR/tzY
	RnajCdHeRZYjoVMaNTtrX9u+7GeCoc3pKuLiORlEw==
X-Received: by 2002:a05:6512:12cc:b0:5b8:e716:64e3 with SMTP id 2adb3069b0e04-5b8e716662cmr1435725e87.31.1790377930246;
        Fri, 25 Sep 2026 16:12:10 -0700 (PDT)
Received: from dau-home-pc.. ([94.28.220.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8e6af1375sm872665e87.33.2026.09.25.16.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 16:12:09 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 03/10] gre: make gre_parse_header() report a drop reason
Date: Sat, 26 Sep 2026 02:12:05 +0300
Message-ID: <20260925231207.542162-1-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923145931.GA2859441@shredder>
References: <20260922221507.3268127-1-littlesmilingcloud@gmail.com> <20260922221507.3268127-4-littlesmilingcloud@gmail.com> <20260923145931.GA2859441@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Sep 23, 2026 at 05:59:31PM +0300, Ido Schimmel wrote:
> On Wed, Sep 23, 2026 at 01:15:00AM +0300, Anton Danilov wrote:
> >  	if (unlikely(!pskb_may_pull(skb, nhs + sizeof(struct gre_base_hdr))))
> > -		return -EINVAL;
> > +		return SKB_DROP_REASON_HDR_TRUNC;
>
> Please use pskb_may_pull_reason() as is done throughout the kernel.
> AFAICT, there's only one user of HDR_TRUNC (in tun) and it should also
> be converted to pskb_may_pull_reason() so that we could remove
> HDR_TRUNC. Can you send a patch?

Sure, I will send it separately. It does not depend on this series, as
v5 will no longer use HDR_TRUNC.

...

> > -	if (ver >= GREPROTO_MAX)
> > +	if (ver >= GREPROTO_MAX) {
> > +		reason = SKB_DROP_REASON_UNHANDLED_PROTO;
>
> This should be TUNNEL_INVALID_HDR to be consistent with the hunk above.

Agreed, will change in v5.

