Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794544439;
	b=M55qp5+KGNg5qtCzxcgvmJRpFSZy/oLL+cyq0GYGNh/sjlOwibWxiQh8py20Tdz2EfGz
	 V3GMbErrJ2ieqeeqKsbJjUHt/HLESa7xpQG0ABQNsMRMvuIia5w8e+4kVyodnTeXbBhp+
	 i3asNQ7jVZWDO+W3dUpZThzf6AH/BxGXLL3xqpTvDvLBeHEbNShp5sT0ofBykGklJb0+n
	 Cej02difWdKZNrazwAS9VKxLb3Pbhk7SXAtxykt/GjmIDuKN2ZymmGcaY/QtxU9HYEWfV
	 XdOwGis8j9Ce2lcKMWw/D4vvKbNzHXKI/P3qK88Jgb0YyZp+K10LCKty/JcE7lrdVyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794544439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=aPxT5oD/vbUSmdWDmpwYPafMdbhb+bVNm7XNt+G51Xg=;
	b=wwmHvywmaoAtedE/yIrzby6yPpEcJF/kvtRfJRAlPHefAf3VukK6tGyxuZhzl8yNBsz6
	 u0WC2K+Z/3vLNedANgPc5xTYejkF5Jnpy0qWpI0em2ygJC+BTw3ti3/+4g9vLUyEAL4lz
	 iAxBzCLnBFGm2mzGryLMuQevB9mEg3R6W+s5ocRqGbMaQESrHETR3PgDTOzMlFBCw/eOk
	 fNMrFVvLlp4+hhdqjgkyIXqMrjMrhfpDlLB6WYBe94h5CIGUARB9Mo4Nkpn8t04xaAAlC
	 HgidRMB8bqWv7txJ/8U49FbCNe+AmIsqhSzfm4lb/p3Mylvu+DjwscPUI2YivEqAhJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qHMJ+F4s;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE87606A323
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 04:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DE87606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qHMJ+F4s
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a058315c79so404287b3a.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794544438; x=1795149238; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aPxT5oD/vbUSmdWDmpwYPafMdbhb+bVNm7XNt+G51Xg=;
        b=qHMJ+F4sRb19CQTTcwA/cen4WjSrhQUjM5h5lcW+Iv1Z/tojW9aBcQFP0IemRR3Pm8
         OF/hgCec+3oO9yuExs+lxxcD7bf0FieftLokddY9B41R9SrHT50qJ3Wcwtf0kX5PFxgc
         8/OI6odne/AlQ/mSWxuPOOHPZ/Pv8RhXsfqZFnLpBiXc0RVS+BJ6W3o7LHdlnmhyy+8j
         +/jiJJsJdt7BD7CFqvvJu+1xUgYIKl5hWkAb5rwBU4OW2BCryGBjMRWrpBaE1czKB3Fx
         HjwikaVHBredEePeW/KjhaGZJTpcoBhzpcUIXsEuokliDLIcd4x9itZz2aiBC6MWQ0dl
         u6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794544438; x=1795149238;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aPxT5oD/vbUSmdWDmpwYPafMdbhb+bVNm7XNt+G51Xg=;
        b=sVey61G+4w9TVQ1cdFdBORvao7KlNLAhyykfdFl45Q5oCz1Xfu+ICX6gGgIUwFbfUO
         SVrLrhQmC6dEXS6zLSymr0uRiYR6jFWRzq2tq3xf6gv0fAlOxR3AwWvW3+t2LkrXDr3M
         jsFnb6qScmMmnTXSMDGCNcOpcd4nrSA2HVXN2lPhKqLTc0p/dzSo5TF1Ucx3RaKDZrs5
         WBfGoHUdmtGNvO37HRz+bjRw08BpztPXwSt4okoh+BYzRvuKM5XyHwqkxqAOhGWWqdGv
         2GAY4YMnDI1qw+FlbeqjPOswkKevxEZIng8qpxAsrdVhcFuApnEg4StsPDZyKv18U3Db
         UGKg==
X-Forwarded-Encrypted: i=1; AL+hErG0lLDyeNL13UdrsY3ZykeUAm++cVtXDgimDN0IvYrG/8FDuqCh+IMfQLI33uAP5db19GLK8EA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3v/di9gKVgnTLk1MESwTBYhYmg8mRFhtJRNbLwcHxZyjppKp1
	W+/9xeT8RCF9D7Mfu2B7IPNQC96DwNMFdEaaBlE55sAVDPZrDQa7SDaS
X-Gm-Gg: AYBFou2R76icwhKutav+O5JyAFWAOkeWWVPf02rBjWCfCDcUPzwe2OKu+E68kNhMCV+
	g8w+M+Mb5QGZobQzFOYZ/CHtQ/VO3Oxsy8YIsjbUtB6T1h2Nu2yQ//T2+04q6SrA+sK5ipJ57lp
	EigJ1R7Yj8Cma/bhQFsFfMexVtqHP+TrwIxXt7EGV3LoQJh/o1YCihaiKqKZ4XYvU89outoMokD
	mveATi1xXvSp8Uei/i9txLWOE8XRt+syQAYzpsRR93ZEyMtw5stdPwwzMffpS7BItUpbim6ru91
	dEpB4xFgrb+XtI+SXET0xCkueuH8uC7enMZAzRV0ZduOWXatvzRFbJ2WqVK3N3wtggprlL3xv+5
	Gu4lO3uRDETHUKJ6sWrTSAW9UhE3tkxnBlA7hLPd9ycn/Kb+QUQdCVWi/CmK2SxSRNVhLjf+buL
	nSVZ2wdohh5SFuOm7QEahQMqU8T9BZVFkJFkhi0mML8NtzeGaw2onUzw02y/puXyizMHBjY8f3X
	MgucROdQqOZaZjUKyF+/3wASkaVNhQSMBp/PAO1RyX1d5MZXSodqbLUBWL+PPqz7IRQ8JchsiFk
	JMDp9ghgfMLkK68AIVYUwSgosY1a6IB6JPe4jIphQfyB0Cxe4TMdHgV2/68qMbxTteGeUJBcbRc
	9PVRuuIYQsJYwxcCF8+TcCq4KmKMu8JT2ick=
X-Received: by 2002:a05:6a00:340f:b0:874:705d:f64e with SMTP id d2e1a72fcca58-8beb6199b3dmr1224059b3a.28.1794544438305;
        Thu, 12 Nov 2026 20:33:58 -0800 (PST)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed1a6db9asm428290b3a.22.2026.11.12.20.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 20:33:57 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Nov 2026 04:33:57 +0000
Message-Id: <DMTSWTHS6PIL.36XSJNJDKSKDA@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, <netdev@vger.kernel.org>, "Nick Hudson"
 <nhudson@akamai.com>, "Felix Fietkau" <nbd@nbd.name>
Subject: Re: [RFC bpf-next v3 2/3] bpf: Add PPPoE encap/decap kfuncs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "ThisSeanZhang" <thisseanzhang@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261111032141.525444-3-thisseanzhang@gmail.com>
References: <20261111032141.525444-1-thisseanzhang@gmail.com> <20261111032141.525444-3-thisseanzhang@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 10, 2026 at 07:21 PM ThisSeanZhang <thisseanzhang@gmail.com> wrote:
> Previously, a TC program could add or remove the header bytes
> manually, but the skb would keep a stale skb->protocol: forwarded GSO
> packets larger than the PPPoE MTU could not reach the PPPoE
> segmentation path registered for ETH_P_PPP_SES and could be dropped.
> bpf_skb_adjust_room() cannot be used for the decapsulation direction
> either, because it only accepts ETH_P_IP or ETH_P_IPV6 in
> skb->protocol.

Sorry, it is still a no go.
It works today without new kfuncs.

Encap: bpf_redirect() to the ppp device. It has no TSO, so
validate_xmit_skb() segments the GSO skb as plain IP.
pppoe_xmit() adds the header to every segment.

Decap: XDP removes the 8 bytes with bpf_xdp_adjust_head() before the skb
exists. The skb is plain IP and GRO handles it like any IP packet.

A prog that adds the header itself can update skb->protocol too.
__skb_vlan_pop() takes it from the packet. Not tested:

	bpf_skb_adjust_room(skb, 8, BPF_ADJ_ROOM_MAC, 0);
	/* write the PPPoE header and h_proto = ETH_P_PPP_SES */
	bpf_skb_vlan_push(skb, bpf_htons(ETH_P_8021Q), 0);
	bpf_skb_vlan_push(skb, bpf_htons(ETH_P_8021Q), 0);
	bpf_skb_vlan_pop(skb);
	bpf_skb_vlan_pop(skb);
	/* skb->protocol == ETH_P_PPP_SES */

I think you said earlier that it cannot. Prove me wrong.

pw-bot: cr
