Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333141;
	b=NUHpSGcKn5eMjZuVfVeEY1VH+0LfsH8qXHHBoJAMDluXLWhS2kRezMyoEumAKgsxE9zq
	 ax1W6DtJEGyU43Xxr1ICrs7QMf3K7SsX8Y8RZc+Go3/czRXTSrFjJzECB6NCWDC4y9oMr
	 DlBHZhKpxnQ+VYUpEMPTNaz9tyopjdHfuB3rLQ9n7ETkm8XIg62fCVFPIbc022723V+lf
	 Npc2zWoKqYhpWIRTTEc3rWRkpkpbXSn3RcK7+6n07S/t5viy6SjgqVOMermUdpLukO4H9
	 dwYgtx7a46j8IIYXjEMaEGt3NEY1rUbZpYz1CABmQtCBnEWBEadKQikl81GSpzU6ugw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rdOmAeG6poyov//lJ4VIygTia9///k0Lcnf6KqKTndk=;
	b=KKXXDVb2j0AUOhJ0woQOAO8oOeeOtW9sCtSVkwcQoIo5/n2lhfc+C/lTAHW56T7DVtpB
	 i3OKmPnA+1jjAEd5tjugaRv1CUbZjQRVXOkXuyBhEzLnnjwxcBE3m6XSk10OrL+q/x7jo
	 iXNVPCQ9jxCNOGym/ejcgOdMGqDnRAq0fRMHyki4nP/U5t3mn+24I9ZW7tMVWRoD91+jO
	 O0LsTqjmLGsZx75qrNzz+XsJaNWQxzIIf+9P6lAQDRLDrayVJ0QGXvSRbSnt2BxwQQKpU
	 NGAG41MunWbEDrp1XXytGXZVANKtrtVaaEUiVMfr+C3sqMJTs2uWrmfDcKIfCQNRS0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Upm/kl2W";
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52554606A320
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52554606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Upm/kl2W
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6df7f544919so1221222eaf.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794333140; x=1794937940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rdOmAeG6poyov//lJ4VIygTia9///k0Lcnf6KqKTndk=;
        b=Upm/kl2WFo2qWXjipnwhP45CQUSdz0AUAlQ2ZTR4etmokvCbHB4jviat920uvatp8h
         u2gtBwHNzwJdmKmXLlgcidnbUaVlwayDRzdO38pYgO2NF4EsCpyJF0+Z3TAcSfyviW9X
         Zk7NQH79Aq1nkMeCEabh9QNaE5RBSP2+6b0a4mRBnQSHDHscFfRGINJSmb0TPHL40ci0
         y0oelyZWXj71erHj6F4E4IknPJwl4hDMjVA6ykh/9X80tREM90kP0IhRxxuMedCGYgvQ
         DxUnm3wj1Sgv32HzMgfgN3GpttgPv34XVQvEc+o37hCy5q46vIwcwc/G2gDbo51MohtK
         lafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794333140; x=1794937940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rdOmAeG6poyov//lJ4VIygTia9///k0Lcnf6KqKTndk=;
        b=yFE4YSC7LyN/LJ3THaXeJX2ShLvO2WWvxhHGL61ScNmcBJickUqf36yU/5E2ClUArr
         hbuxpxOo2Yyr1e0h28aFB16QktSc10QxSRNcg1TEa1IQKUL7doDEdPPuIGyQ5JZUYqDL
         vFBRa4BaTD9jZi/9YwpXwZrkzvVT65q52IS0/LB0sJ0VlY0F0bXnn9YbPAGP/Z3pGK35
         uQKEz0uhb9sUy6nQ5opfnrUoKg6eMO6UbkaG1dfOJnUMbA2ZlqW5inKUF+YtxWgTZR+n
         eYn1YCn4gL8IFuVNtOOctw44yiUfs2Z4eq0a95tlCdijb/iSp5/pMcfdXKpm7gvGXv86
         YUwQ==
X-Gm-Message-State: APuU4Z+zbJWPwnO+bNRmGBUftRtwzG5OyU6+kZgtNki4GREzbmV9pCiR
	6jrGoz2oAPLSD3Rm+nX4Rk5dA0/twjvEsMKdMMWxWoN85Kyji7cz0qesFmPAuePR
X-Gm-Gg: AYBFou2VltCLaGdFC/7WzxdWUR2WnxLkU7LiAYf3we4pOK2TbQ2oVrqLVufPVPbEtrE
	McDOsOyYCmBqUy3BkCw5zPJHMJzMZ+8nSIP7pnfoLnLCjKgct3ZmQLQr7zrghUs/nrtRwvGpoKE
	EYZIg1dkP71PP+XEEP2jOVyGU7ILSf8WqG33szszgXusjnluhHnOumDIk7oMwoKIt+HKSeK65+Z
	SFMDsdwn+8OonylD+QDnCUOkb7hYVSFzrWzJzjWEQXdRJ87nrwIioeb3GrRBRlm4aUTiOZ3kWIj
	qDllsIUIQi1XgrUY7DLle1lmKM+yRmUNVSwebNQoy+6cXGSCtjP6bhvXUK1puz0RJn2Oj0mOofM
	IKkoesFsXTGDPTjQxOXlaDpUQbVl7C9RzhmJjd/latCLTax9OD1xrh5UIYzg9JdAlMVIXkbxZx+
	S/sGL1GY3OLzxMxOPV7hK1z/VOuROVYLC/KcOZMAGEiLiYTaMtPZn9IAslThMxFxiAvm/+I10kA
	cT1Awci0ExfiPjtPR+mv79yPVWAsey5G9IFBt4rk011yP0EqIVL1Va00WvM8tFPbErFGzL9ouKX
	CDHEA2BWHjrCXTYJpuMN9w+w
X-Received: by 2002:a05:6820:839c:b0:6cd:3ffc:ad01 with SMTP id 006d021491bc7-718a721c7f6mr1281321eaf.81.1794333140171;
        Tue, 10 Nov 2026 09:52:20 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-718a8f660b2sm2127174eaf.4.2026.11.10.09.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:52:19 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org
Subject: Re: [PATCH net-next v6 2/2] netlink: specs: add ovs datapath and vport set operations
Date: Tue, 10 Nov 2026 12:52:05 -0500
Message-ID: <20261110175205.978410-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <179414156884.994134.5015506800657224516@kernel.org>
References: <179414156884.994134.5015506800657224516@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2026-11-08 12:39, Sashiko wrote:
> [Low] The min length has no effect for this family.
> [Low] The vport set list names attributes the kernel rejects.

On the first one, the mechanism is in the generator: TypeScalar.__init__
calls _init_checks() only when the family is not classic
(tools/net/ynl/pyynl/ynl_gen_c.py:375), so for these families a check
documents the kernel policy and nothing else. The kernel enforces it with
NLA_POLICY_MIN(NLA_S32, 0). v7 keeps the declaration and changes the type
to s32, which does reach the generated request code: it now calls
ynl_attr_put_s32() for the attribute.

One disclosure on the same point. v7 also adds a max check on
masks-cache-size, for the same reason, and it does not reach the
generated code either. If a check that generates nothing is worse than no
check, say so and I will drop both rather than leave them in the spec.

The vport set list no longer carries the ifindex or the options, and the
doc says that a request with either of them is rejected.

pw-bot: cr
