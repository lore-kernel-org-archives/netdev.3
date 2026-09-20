Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4561A47140C
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789924010; cv=none; b=Bevr0lE6UUEenbfZaC07Ml+jmTvQ1gS/NZDWwD1PtXyOixE2GBP9GsUZxNJGL8AETFWLMXkgC2FZarwyuWU3NITenoh6/CABzWNFkb6iKK/BeNH9oyHRHMTyuBPPZM5VJ/0o4is0kaYZdjOV650hWGczXtDDaZLVoHTKW/mYmGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789924010; c=relaxed/simple;
	bh=zyIl1YnF/JeDemR1K+Qanp4L+ZXF5mP582Kn34vWEy8=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=ja2JzVAT9LQFOX9H8c5tprmgRuJIFgXgka/E2dcIgAsxm5EdfFhjMlZI4r8kFZrGW1zcDb+b3dszPItQr5l2oWmUIJSijim/39Yq7texrzAnqcdGjCdBJJH2TkfAURVAjDeQnMNuF7fflyuXDvYD+tYQuaTc9lbOyH1JUjekgRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISqT5DKM; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISqT5DKM"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccafb751so1848237a91.2
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 10:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789924008; x=1790528808; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YjWfIDJ8pChJcBT+tDEEp1v7Bwad+KNaOWOCVwGIFkE=;
        b=ISqT5DKM960lQRUriozMuzkHZLrb7N1gpYgZklj3uckDCsFJtJzKVKkbqwKO5hUGKi
         zDQYcoKYG4TGAb/ZupyK9u44lWqSBGDjwE8zjJpSJc90tZANict9P4G63mHO6EwsS1kw
         xdE19gyxnUR9NGWWmDoSVKqh5m+rkQBjuHy0tJZiZEzch2bnl8jE6X+8NOWFgoKN1KCw
         DgkJByv6P+Qf/CgX2matMw66vLlf/mM+9cNw9r+dRAt0GDXYRATo33F8bAZBH9ZSgG6Z
         WxDzlOEDBGBl4xawrGtuomiEtN++daha1qP0mC2kkkWbp18h03D4ElMBLfIUYzmJFNqS
         0wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789924008; x=1790528808;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YjWfIDJ8pChJcBT+tDEEp1v7Bwad+KNaOWOCVwGIFkE=;
        b=ljyZJUstLm1n5S8NM/CrfNpJn1pDBEn4p/sklsSvDGDpWUsaXuVAYC9wiG73PTGRlE
         SgHQO1mtRMxGxUL0+4ixhKnGX9i2EKUyL8YeZtP88RhF85qbti1IhpsC85bSUoubXItj
         UndXy3HrCLowBrl+j2LkIu46LVFiqfhCR2ywJYfjxiEfHwl3hD3Gbqp77Ur0QsQkRp7v
         mJITbpU4puRKgQpEPoP2x/nhTG5tiba2/2RmL2/qyLUIWsc4UsgIxm+qWR+HFEgnNzPH
         p5TN/AIRiABUDbSWTN2l6LRROohAqwiOz5QZd4iBI8nVcOPTQG+KVSPbMikgEMoBbeQt
         a7UA==
X-Forwarded-Encrypted: i=1; AKwUvByUpXyqsNlFCjTFESECHFzKMN9IzjLU9VXloePCdBtj6dTQOY51wGOp3VIdaSA9RlgGptWMFn8=@vger.kernel.org
X-Gm-Message-State: AFuF++k91BkYm6qINcwmiE009E+mahPQ7//vsB7OXlXlr8ARJ4oyCwD8
	YJpysjb2q6OuBo236MPu/FZHeVzUX6kSa5yuAMyF9fL5V65AruNT5VBu
X-Gm-Gg: AYBFou2PFP7GuSxriKdJj0UtubZrg/v4nr/7mPaHUgtbM0qLKObZfGlppfnPhC55MEq
	a2y/E3553Giytk5qPz3c14ijw4Jo61ZgmXvehTh+Q9bdp6cOVojxSikbAsrj0OPKSqphwImTNz9
	fOr/hR6liJCjmPcUXCeApNGKA9YNX2HUfpfvhTX/7oP94RxpC3EsvwvDundJ1uRaol2MXE8kFKH
	89IbSLMI+kc/INAw+GYLanTzdwUaUYVwZgprGdmoVvzyl3dgzY2iz5BRrbYoVTk1JhgrmkDowL+
	MuD3tUVlgQgCB/k32qfBM+BrMsCTqoFyIZIQRSIq7ib3iMmvWRE4Tf+aqDPod7GieBIuJV4bI8p
	8SUvkrMDKJPhmPl1j/MpvOSdl5rlGhJnHsljuPkGccQLYWoQ227VQ1EK0wvX4lbGBB7vIxOdpup
	HQde8cJYVMlJf6ISFhB07jCbONZAbZVt3XTPb+WtQ8OlooQk6WloTrj60h44eWILYHExCj8qx69
	KLWg2twDFU+BsR8i6JjUliT0QNzA1FPMBKUFQioj4iDX7dBj0UoPbIaIU8UFhtUOMmBsk7Y7KWY
	uqDH
X-Received: by 2002:a17:90b:2d87:b0:39d:e54c:8658 with SMTP id 98e67ed59e1d1-39e54d8ecdemr20165760a91.5.1789924008366;
        Sun, 20 Sep 2026 10:06:48 -0700 (PDT)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6bd191aesm10168886a91.0.2026.09.20.10.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2026 10:06:47 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Sep 2026 17:06:47 +0000
Message-Id: <DLKB3T7PYCND.3FLS0I8UEX9NL@gmail.com>
To: "Weiming Shi" <bestswngs@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Peter
 Oskolkov" <posk@google.com>, "Xiang Mei" <xmei5@asu.edu>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] bpf: clear stale IPv4 options after LWT
 encapsulation
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20260920163211.795547-3-bestswngs@gmail.com>
References: <20260920163211.795547-1-bestswngs@gmail.com> <20260920163211.795547-3-bestswngs@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Sep 21, 2026 at 12:32 AM Weiming Shi <bestswngs@gmail.com> wrote:
> Select the reset layout from the protocol callback which consumes the
> packet: the original family for BPF_OK and unsupported redirects, or the
> new family for supported reroute and redirect paths. Preserve the ingress
> interface and L3-slave state from the restored original control block and
> initialize the IPv6 next-header offset when needed. Save and restore the
> marker around nested LWT runs.

What Daniel sketched in v2 was 20 lines. This is still an overkill.

[...]

> +static void bpf_lwt_reset_cb(struct sk_buff *skb, __be16 orig_proto,
> +			     bool use_new_proto)
> +{
> +	__be16 cb_proto = use_new_proto ? skb->protocol : orig_proto;
> +	int iif = skb->skb_iif;
> +	bool l3slave = false;
> +
> +	/* VRF may have replaced skb_iif with the master device index. */
> +	if (orig_proto == htons(ETH_P_IP)) {
> +		iif = IPCB(skb)->iif;
> +		l3slave = ipv4_l3mdev_skb(IPCB(skb)->flags);



When the family doesn't change only IPCB(skb)->opt is stale.
Clear just that like ip_tunnel_xmit() and udp_tunnel_xmit_skb() do.
iif and flags stay as they are and the VRF special casing goes away.
When the family changes do what seg6_do_srh_encap() does.

[...]

> +	use_new_proto = (ret == BPF_LWT_REROUTE &&
> +			 lwt->prog->type != BPF_PROG_TYPE_LWT_OUT) ||
> +			(ret == BPF_REDIRECT && can_redirect);
> +	if (lwt_ip_encap)
> +		bpf_lwt_reset_cb(skb, orig_proto, use_new_proto);

Not needed. BPF_OK after the prog changed the family is broken no
matter which layout the cb has. bpf_xmit() drops such skb and
bpf_input() hands a v6 packet to ip_forward().
Use skb->protocol.

pw-bot: cr
