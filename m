Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376213218BA
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 23:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789859909; cv=none; b=icjl2rlo3DszEAyEF+gClMBTMDVKzy/PwBHb6h3enFTV9EkopJ7OBIC2xvUVOyxc2ehtzB1vwSt61zp0TFpWEtepKFhtUQAWghs26R+RgzdihrxDPoKRn4J19odYAMzIrK7BnhF0j4tnoVFITsqpBnkP2RVK8KJMHHhfs3QhA24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789859909; c=relaxed/simple;
	bh=afubjmtK6J69d9gjWzx00ieDaqApuKhjmcImG5ymlNQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=AZywS7KFXBYkcKHNzefR+QwC8Sc7473EKZHNyd4Yg5vH7c3GLXVRRj5xFl8eg6eAzKTACaAQvRo9FK2hL0eBJjg8xb23SrLNLV3kXudI4udcnqf0FCMduur/kIJ3EtN+0aNXrpPZi+Fq0Ku06C4F+HRhth5zqeg+6yJccy8qvRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxqgL+89; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxqgL+89"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so1624357a91.2
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 16:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789859907; x=1790464707; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sUuoRL2/TITlGn0R3prNUIqDwgNFzk2wNFbE6aU/ybs=;
        b=JxqgL+89t+ENA8TbE3a9gpcPYolq0+DKEIYpBu7SK/0p1F0V/dRsYEeZBBYKWHP+gm
         qciIgVyuXllKAeHHMxGWtIF6546WUBGjvus1rS68gpmTWJSythf/kj9HNtpUpxP/pD89
         bHO0eErW9C29GVzCHHvQJCwTQwdHL8/Da7Li6gzw75mt/GkarUIJdmq9aZeepWyWvCjD
         pc4a0bni3Z0sK/+i6o8+m/etYsS0B+SSHLJPPmGLWugoyg/1gbZLTzBZnmAWc2n2zIei
         O0kfnWJjyZROzQR8kBuYot6au+sOO9VACQkOCQIgEO4/g+A0EJWlOtkwc40mZH8YyKUN
         2P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789859907; x=1790464707;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sUuoRL2/TITlGn0R3prNUIqDwgNFzk2wNFbE6aU/ybs=;
        b=Fo8BxsoKIxJjwQEZYRHsT6yhWSVdaSEb/NO625IapeMWpfakWM3lg9oQao8rD6iG9e
         z7xKWElkdn6HMmtaQ1hYfY68hK4I5bpqAzWyJ5Au8FEiJpbptHnJng08wuOifCt9DUWA
         nXGakXajsWCQ/HFIbaSdxpJpFQ8JXI9Kmq2M+LgwJegTCoa1J1ILsSDU1znCJ/xq/9mw
         1sLFxl39GHnK1ceIabWpgKJy4Hproy/KU7I7WZj56wyGUX5YEC2K+3ufVkjuXv05uP38
         kM+gjHZnOWgldqt6vuNLXYrrc9DEaDTbt9SZ5pYDtQnQOZhfmFZWAJVf8LDQCy0BBlmB
         TB+g==
X-Forwarded-Encrypted: i=1; AKwUvBzLbksaXX0M+Rz+lxoCllSo1+iPGL0coXjCqsxuS+K2O66zZxUhJfdNlzTC281BgYBUr0mN7DU=@vger.kernel.org
X-Gm-Message-State: AFuF++mzByWSZH6Q9Xa373oYaXlS5ErE2Yapy3dpBvJCFM5zhpyp0hD7
	w4jQ3NzUcIgp/AGN4TRycH8okop0rCiC8YCUIBTFedH+QLC+PAJula2M
X-Gm-Gg: AYBFou35wTGl4u0O4Y+4Z1FILZGpiWcjOzURQ4dRcQ7mKGVRCiT01VUkeqEJpGUUUaR
	GNHoq2ISKEoxMi2EeFqy7lrZnFArNjIrC5+OV4sRs8Rx0PBp11bjMbB8oIH+mWA1BOZh6UVFILa
	QhCCa5JIccYedWfqzxHR/xesYfnWsM8fZZ1om2bAkyCRg15wuzPP48IGjXjfjieksyFUGuz2AMH
	bO9uaW97YQ4XAX93qbV2gKP/Jn6pGLSGJthp6/kA8r+VDGhJucJUVD7/QBnyNkugUwcxUE5nwVZ
	06dlmskeFfJ4e/JrT+M/p6Cv8+ihnJZg+JCoPzcrhYLVjTC70zc5yV/HAVfmTkQdisgX1NKTunv
	JwSfrJVACkcJ/sunH4xTDaGnaRIrCogY6469E5vah88vUukcDwiESQh5hhKw7hIMmDKin5SBf3P
	sicSbOJO9SuzluO8TmLLMsRsAOD6rriCcDR/U5dzT/VybEMiwLOmVe3rkjF0PvbL0JcFoZfGhKB
	8sWK1aVnJvJv/p7W9z9xVbrL9TO8Yz8GW9E6NfHAKuRWiePp2fgQs++jboiZFIxi7Udpi2NSJQ8
	Sq35
X-Received: by 2002:a17:90b:2d47:b0:39d:f4fd:8075 with SMTP id 98e67ed59e1d1-39e54c9c7b7mr11531713a91.19.1789859907264;
        Sat, 19 Sep 2026 16:18:27 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c164c18sm6403791a91.1.2026.09.19.16.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 16:18:26 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Sep 2026 23:18:26 +0000
Message-Id: <DLJODTPSL3IT.1LQ0SJ80PGO1M@gmail.com>
Cc: "Willem de Bruijn" <willemb@google.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: reject unset network_header for SKF_NET_OFF in
 cBPF load helper
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Hui Peng" <benquike@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>
In-Reply-To: <20260919203517.2581484-1-benquike@gmail.com>
References: <20260919203517.2581484-1-benquike@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Sep 19, 2026 at 08:35 PM Hui Peng <benquike@gmail.com> wrote:
> diff --git a/net/core/filter.c b/net/core/filter.c
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -231,8 +231,14 @@ static int bpf_skb_load_helper_convert_offset(const struct sk_buff *skb, int off
>  	if (likely(offset >= 0))
>  		return offset;
>
> -	if (offset >= SKF_NET_OFF)
> +	if (offset >= SKF_NET_OFF) {
> +		if (skb_mac_header_was_set(skb) ?
> +		    skb->network_header < skb->mac_header :
> +		    (skb_network_offset(skb) < 0 ||
> +		     (!skb->protocol && !skb->network_header)))
> +			return INT_MIN;

No. network_header == 0 is a valid value when there is no headroom and
skb->protocol says nothing about it.

When netlink_dump() had this problem it was fixed by
skb_reset_network_header() after skb_reserve(). See
commit 99c07327ae11 ("netlink: reset network and mac headers in netlink_dump()").

pw-bot: cr
