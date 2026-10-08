Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161DC443307
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791497615; cv=none; b=B49C0aWd8zCkgUO0PSM7RCbRefqWKIRM7hHCvEqr1uK97dOUHsyNkpixTuwUD6L3F6IQoqOzqqs7KT6+wR3Cb/XTrTp1xVCyKgb9fM/Ju3uEsdg3Ys4T0azrydhaYeCTVxnotNyxPOqKLzHn8Fqhz3EyY5h429cZQqdQEphAXqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791497615; c=relaxed/simple;
	bh=QWeHh347xkXbhhaGjgFJKSrFsAHNyLUdHqxJH+OUYiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oe1pvctPabBXON/EyrNS/wODdCb2dF3aLpM+Lg5G1tz/j1yi4RGFCUcd6z+mvLoFtFlSxuwpIb+BjF9nyb4ywFqdipmsRmdH4DqGChBFjUjilGx2xmghsc7xNSqEXpkORrst2VrsRheL3bquKya+AbbOMqoDd2zpfffZ1EVydR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1lqMC27; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1lqMC27"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-398b9f722abso2530066a91.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 15:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791497613; x=1792102413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XXsm0FjjkjKEAQ24SJqzlYE7Kl2Ig/4x9h23uVVh4Gw=;
        b=c1lqMC27hj+26ND/rq5Uhpl7kO2idAvZ7ZR9eJxoPZct2E+YLh+5DoQ3U4EqGEMlwG
         Uu5/IXGj6bSwpmqZaqd/jzN0ytN7jUA5x3MqFEIQjvNXDJXhEiTV18/34/l4UnK8KYo7
         9k+TFmTZcwhpiHmss7XsKU5ijTQi9zwGF3fXih9b1FT4pTE0CSJZpszf5P0wXOj+Y26I
         rB6LjBRsGoUY0a9+RMSvVjSRGgQOdurL0FUaieJ/mRqEkBNxfDt4RGEAnweCT8FAl/XF
         jXpulXPu0nSXwq86drdS3wfmDTSaUsplOo40OxCH9W1Kf/R1m2gQJP5vnbNbIZ8s7qQ3
         EeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791497613; x=1792102413;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XXsm0FjjkjKEAQ24SJqzlYE7Kl2Ig/4x9h23uVVh4Gw=;
        b=N2UIVFgHGzGflP/6iAmq2O6wuHqacClSTxCDHVhngoiDGbCnJi9Z+u9SBthYcjZtCa
         Fui5icrirPxZKxiV23ZNcAz9FjChqdAy3ZmwZ5C0EM8urunB4ywyzHTTH9xgSDh6Nj65
         nSaTqLPYK+YfIG7b5L85eF+8cq0Jwy74kB+ePcizKSzyUMpaWpyCGFpoAOvks4X0dyid
         CBuMRciQNPwW0G4ATNo9LiM2oK6fEDBKwPH72uAB1jocK3RMuW9OHoMfRom2iYSD8NRw
         P5MP752jLnpKZcYmMLxUAjYOsR1t0d03Ze1ngGbb88Q+A57oHApEY0OuRin3wCUpU0NY
         uV2g==
X-Forwarded-Encrypted: i=1; AKwUvBzkser9yGA16CD/wZzw2ydKbDTA8LV3BRfYeFZ6GMLbaD4SL/HnmVZamCyC1O474zXrYQAeGaQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9piiWZUu0o+wEdMkR6RS6q4sWiGMWI8BDtsdfer/5J3FnP1Wi
	AvOXbWLLSSC77/AE8/lWBE7CFDeWzEgOHdiuFXy+fz6lF65XHjKHogFN
X-Gm-Gg: AYBFou2a3oQWFWBgw+KQ8aemN9xxzD7D4wCLy81Wqytx/UAOZnCplXGlJJrQwhjoq26
	DjvUptvIpL4sBFSSphMDbY6vLbtzQANLITHCj0TAnC8A2DcA5y/LVPvWvcurDuPjriKEzIV7RD1
	+T22oTxPN/HmIn93CcxZflPtre9Rii8BE5OBOzVbp38WhqWH9q/AgqwxvR/oKVInFgEIsU+ODl3
	/U6SuMX4wlyt1GdqLdREq2bzsjwsDS9gsPIQEZdQOJUMVGoNarK5LoXkijARfUmg0HOzk7Vz1tt
	vcYZrCLuchCqILhgebWjvIXb2b83JUueHAe9OggNLIH+9RVpQSBonXiPoYZ+jIueihGF9AAgA2E
	/6iyWwR7XYgcb41ypnc1tFxpTkMcONTwM+SI9ANFrTDlABu+cB5OzvKdL52qnJuoU1t/Wi6ps4n
	jUhJ4cL0LiLvIjqCqE0v7jqJJ8MyuKJKVXl0OpnLmkVvy0lhFaOJR9jyx7n2pbY4pl
X-Received: by 2002:a17:90b:1a8f:b0:3a7:a6bc:9d4b with SMTP id 98e67ed59e1d1-3ab3afe44edmr129584a91.59.1791497613440;
        Thu, 08 Oct 2026 15:13:33 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:54::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3371f748sm476825a91.1.2026.10.08.15.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 15:13:33 -0700 (PDT)
Date: Thu, 8 Oct 2026 15:10:34 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Ralf Lici <ralf@mandelbit.com>
Subject: Re: [PATCH net v1] net: devmem: prevent mixing fragments from
 different bindings
Message-ID: <asgU1AE75SWgC-wQ@devvm7509.cco0.facebook.com>
References: <20261008033952.1399670-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261008033952.1399670-1-almasrymina@google.com>

On 10/08, Mina Almasry wrote:
> validate_xmit_unreadable_skb() only inspects shinfo->frags[0] and
> assumes all fragments in an unreadable skb belong to that same devmem
> binding. However, tcp_sendmsg_locked() only checks that readability
> matches the presence of a binding (skb_frags_readable(skb) != !binding),
> allowing consecutive sendmsg() calls with different dmabuf bindings to
> collapse into the same skb and bypass per-device and unbind checks in
> validate_xmit_unreadable_skb().
> 
> Add net_devmem_skb_binding() to query the binding associated with an
> skb, reuse it in validate_xmit_unreadable_skb(), and check in
> zerocopy_fill_skb_from_devmem() that existing fragments match the target
> binding.
> 
> Fixes: bd61848900bff ("net: devmem: Implement TX path")
> Cc: Pavel Begunkov <asml.silence@gmail.com>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Bobby Eshleman <bobbyeshleman@meta.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
