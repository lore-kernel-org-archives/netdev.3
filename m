Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627FA4BF949
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975844; cv=none; b=BiOQNOmncPLA/pk1X+CXJRCkPQTcAnynNv3uYylRC6T1MGvw42JlpMvn8KatUek4LqJRSZae4HDKwAWQ63/cCDMY803gVUn47cUY4JNVLOrZcSEXsZ83vS33KfOOS1FZu1YTD4TN3TD5uxiNgSFaPmkKZJh3bfAL4ieo1DlgmRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975844; c=relaxed/simple;
	bh=XsGHi5FRsxGlXy/BzAv0634cOMAQkocEqD+0pVJs0jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mU7u+haR473xdscnP0y82iv6iy446GwvrAjAe71gM5h6LYaoVVJeoNSzp0HN18wg8ssQ6Ydts3aTCW7dfv4OV3NZp9ClmlXf4pooycC84vuJMGBG1jTAELi4iWvJBiB6nh3O6YAryU3/T+/NnCtnahUFeRDdvXCVG8lgd+MFT6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gc10swPc; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc10swPc"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-8252259f6d2so2374771a34.3
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 04:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975836; x=1792580636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XsGHi5FRsxGlXy/BzAv0634cOMAQkocEqD+0pVJs0jw=;
        b=Gc10swPcLmrHqC2BSK/CshBxX0HW9CRMjuDDX4R0DM+jF9w+N84Kll+lZfH9N34LJi
         u81JQ+nObDKgSFTRCalLA/ROImuJ0BUphO6pUeaUCsdtZGiMXpYWkBHgUdn86ouSrjLA
         n/ykClBqi133Dny/k7uGgMttzL9fob81f+d/VurosHjqdCEDs6LWCcTmNthoa+4iy0B6
         S6YSSHRRb29NC8TTubjPyfuhIdBdc10GNS8E5LDF8Kng0jbvFNeOqKAk4tvtmy9DZ1xM
         nrOWGjt+Q1lhdu+VJE9JBmNUaOtZTNgGppYgrSONHqJAkL7DgbvX1cO/rEnn+4xD7q7i
         FS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975836; x=1792580636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XsGHi5FRsxGlXy/BzAv0634cOMAQkocEqD+0pVJs0jw=;
        b=kAq67wrZlnA4cBIslALtCXvWq2KlacubIAGs9nByQtL6sm836N7+vsrU2nrTW3lSvu
         nDjisFeQiJH6WEtJhwL9qN+Hwayfkf9pww49D9KSPlsE2Y5a2pOILr3b93opRulHLz6h
         ws9pH3ZiZiFvYKvelxl+Luf3KuM23xx75d5RfEA7kXE9OOBzCZ1z1MzHM5ovGpHh/YHJ
         8plC1H0ELcfh5KnsT31spRlSA+i4ZPMbQXJ1wtvzccURS496lA0UICysbJJG94v3iz/E
         6bG57O5bL3RbU9r4WHkoXxZo+yFai2dCGSj47aH1whGxXMGAZDSQ6sK4NKQ49OJkWcUX
         yqKQ==
X-Gm-Message-State: AFq9FYKmOpoBC3E2+kKA3c79zxGsKluZZiVXT0CqaEqxSJOH+ufmaq+k
	c9evbeDyw+r+BCutSZBjis1ltr8C9NAR51ksdMrY14ePVH9Q86S+v0K9HU96SW1E
X-Gm-Gg: AYBFou05DX70Baq6/OAoLl4Bqj+7V8zM5NY46YoN8y0HZwtNJR58cuqFPZ5Z8hiW54p
	aGlD5UxrnP4gkHMYbalcbsL2EXAgpr+zvxBQ57Al9FxfJeQILHwFd/vBnk4PhnP3hUgCMxSGuei
	wHn1LqmIuDHE8RI7mQ/0x85g0SgyzjaDkPyQJUDlcwgwPZoFJ7h7UuBTqUbhfKS9G4oFWXqtRNz
	o3gDOYqrI8DF3b5R1JSu2+6z/Ukfoi0Sy++/9sJN4ThWgQDTeZ9dwtu3blWuE+Ksi14ZzZxh+1N
	v4mqwwvuAtK2lPqqagNCmRlT4NJHzj+xq1BMJDa42mW1cxMTWwn/qfcOLgGJLQ+dRajANLKVi5S
	Xhq7W8KqSMMAg49guznHkQHGDGIRUPfZaIPi8Ai6MEHbkICOTqgljuuvmqlz7bwsR4XQ3EarzuH
	i6FAZZo8uw8+0KtW1gjTNAqPZ6NfvEgkgybI8430ABhdnTOfu01A1JASGzElL7Ar6i
X-Received: by 2002:a05:6808:1991:b0:4e9:cbdd:457d with SMTP id 5614622812f47-50c4dfb7cc7mr17875352b6e.11.1791975835804;
        Wed, 14 Oct 2026 04:03:55 -0700 (PDT)
Received: from houminxi ([61.170.226.68])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6dfbd6a92sm1793351fac.9.2026.10.14.04.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:03:54 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v2 1/2] netlink: specs: add ovs_flow del and set operations
Date: Wed, 14 Oct 2026 07:03:43 -0400
Message-ID: <20261014110343.2567026-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179187709747.434549.16040884181450649933@kernel.org>
References: <20261006130533.1620706-1-houminxi@gmail.com> <179187709747.434549.16040884181450649933@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 13 Oct 2026, netdev-bot+sashiko@kernel.org wrote:
> [Medium] The new operation's request list still leaves out ufid-flags
> and probe. ovs_flow_cmd_new() reads both.

Yes. ovs_flow_cmd_new() reads OVS_FLOW_ATTR_UFID_FLAGS and
OVS_FLOW_ATTR_PROBE, and the del and set lists in this patch already
have them. The new list did not. v3 adds both.

> [Low] The commit message does not mention the probe type change or the
> uns-admin-perm flag added to the existing new operation.

Right, it only said del and set need CAP_NET_ADMIN. new takes the same
flag, and probe changes from binary to flag, which changes how a YNL
client encodes it. v3 says both.

> [Low] The key attribute doc says a key is required for every request
> except a dump, which contradicts the new del and set docs.

The doc was wrong. get, set and del all accept a ufid with no key, and
only a new flow needs one. A set that replaces the actions still needs
a key, which the set doc already says. v3 changes the key doc.

> [Low] The get operation uses one request list for both do and dump.

That list predates this series. get's do request reads probe and the
dump request only reads ufid-flags, so the two should not share a list.
I am leaving it for a separate patch rather than widening this one.

pw-bot: cr
