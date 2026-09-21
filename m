Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622E03515CD
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 04:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789964975; cv=none; b=H/yBfpd9+lvcBCIoIQbbJCKd59wR1GWjTTnYAIdnQQmV5FWVkhgq3wtk45p5oO2/kb6wAkMw/X3HMapXISSw5+p6ZlEf3bhzvnk9k7/EhD0xElVW8oaHfxFGvTquXt/l5C6t/kxduevmcmVLl0CmB9h8Yp4L99XUiOoeLdOTiWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789964975; c=relaxed/simple;
	bh=EZLcDrNg0p7u3xoE2NaBQYfiA5P6zOjGWIsa0ShloL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rw29X2MbYM+nbwh6IiC2+nOxWzauWiDWXArkxHIRknj0xdDx7NIo0qTZZ3SXZy990taTFqjxQ39ygXBew1TgTohCh468Iq2X7pLmLZF+yIfGKyEXfCQjUOuVwldfSJ6bdCfRvbWn2SzF1CUTLredNGM8F5odYA5/mP/3fzvhnuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=ag0UyYwu; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="ag0UyYwu"
Received: by mail-pz2-f38.google.com with SMTP id 41be03b00d2f7-cc1cea4c7a0so1188499a12.1
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 21:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1789964972; x=1790569772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X+ARZ05U0Ry/4bPhSuYtgrWnaz/OcQpWLrFkKl/prSk=;
        b=ag0UyYwuzMXRWRrydL2p3etfZ4L4o86Mg19du3tKsa8Ujp7FceO7CVxALCsEJanTM5
         p2jXA93qJmD+qmCxeX+7vEtAFlobm2qGoXkAAT+nTXVoZyHzPXArbDFWYIYWqCfciRpn
         nkJWZ1PzCW3RZ+BER5B6Ql55pUXyDAwLKSJv4c4IPIJv8Exy9KiRERDvftn9a7uwrZx+
         HzddLks6gLFo1xFm0BsJ1I3lSITrHDnKbCAhpr0KJSnhC8W1eubWcEg9Z5XlnrWFxOR6
         jakSn3ab3yD5MPRfTf17eFHVnJGSiFKSo5Xrsy6YgtWAqwymV5/xl6dkgdugIEmSPOEh
         LUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789964972; x=1790569772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X+ARZ05U0Ry/4bPhSuYtgrWnaz/OcQpWLrFkKl/prSk=;
        b=V33oUkyfJeV3s1vwfVEa2zRkKGYxdKo4TKbqtAi2h2jDVV86GXCU7Ze97g0dMNtg9x
         RlZl9A7LYA1hXIkEZKymGf92hvewKnWLl2ANh5w8FZECo4XWsqai/2WNtXlXInGdTcON
         c0WjlTQFPClPnlFr09+99pAsd972g8Kh4WI8JKXeatYlQG5eUWk2O/3tMUKdlWDmwf4x
         I4g5+9L9K7Jywmxavsa0LQc2SgSRYQcA44AkuGwEd3hHqr9Hm/50JqdwYk+f4/EvegUM
         Ow5hDDVXH3XXMvPgjI2U49kp4SteCnzer95EJGjWmI1lIWdM/atTShryG4olJsHqmQld
         xKZw==
X-Gm-Message-State: AFuF++k8CDXy4KSaNrWaTJcCeRdn43t68LND0GZ9isCMzyZoMO/CrVUW
	1/xlPzN7rAl4p90bBCi2c8C6eSGwDGi/ueMHvg5ZFfJCq7SbiZu4aHFiVy+77Fyj8DmerYh+Dox
	jkwd+pLLzBYLQQOUTyyz9PZzOlx6aebgG2ocmyDlEZKB+WmIWSOVx/47WN3SdqUirgTRy4QN3Fs
	2Gaw==
X-Gm-Gg: AYBFou1WI7C4R771KJA6UFvjkJZOj5eaEWkAyCQc5lJBLBcl6aTafJLnSvRzO8jeWDq
	VRt4qycpqDOEMysT4rfiQtGSogIR5cjpmuHVlgx9E9Vl4rLNvAgfBh3ZU92O7x4fbwQv1BZjVXN
	Ig+hE/z7DD6A5sITebcXp9eUl4KdwUkKbg641b9fJLnSwb7ba1SNszpLemEBrCzHaSiYIOT45ES
	cYT8M14csmV+RMT7C9qbpHta9fFmiA6wa0vXiISAe9l3jL6gks2MvmO6dBrl/IKRDE/Yo7GbzG9
	8c2AwDdYtVh33fBE6ef26FbzpI28A1ATw+ETqhkV5riphvdEwLbV3esS+1lWswnr4romeb6TmZB
	EHk2lVF6RVmbDbP8FlSYr0rY9t3sW07xlfP1cDRQa4GU+x5yELWwSG3aMjasyn8XWXtBvFP+lzU
	AmFp2hLtgHwbZxxoYbKIC6nywY7yZWxHe0iVpRGZkuLPwZrwbMXPQazlOPla6R2y/u18USu9tsX
	nHjABeJPvk=
X-Received: by 2002:a17:90b:4d0d:b0:39e:6c6a:208c with SMTP id 98e67ed59e1d1-39e6c6a31edmr8745588a91.45.1789964971912;
        Sun, 20 Sep 2026 21:29:31 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.241])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144da432647sm25579483c88.5.2026.09.20.21.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 21:29:31 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>
Cc: Wang Zhan <wang.zhan@smartx.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	dsahern@kernel.org,
	idosch@nvidia.com,
	willemb@google.com,
	kuniyu@google.com,
	kees@kernel.org,
	richardbgobert@gmail.com,
	alice.kernel@fastmail.im,
	gal@nvidia.com,
	jibin.zhang@mediatek.com,
	luoxuanqiang@kylinos.cn,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>
Subject: Re: [PATCH net v3 1/1] net: gso: limit recursive IP-in-IP segmentation
Date: Mon, 21 Sep 2026 12:29:07 +0800
Message-ID: <20260921042907.3658794-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <43510074c063f57e5738ecc55057e7fbbcdb1fbc.1789802623.git.zihanx@nebusec.ai>
References: <cover.1789802623.git.zihanx@nebusec.ai> <43510074c063f57e5738ecc55057e7fbbcdb1fbc.1789802623.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 19 Sep 2026 11:14:40 +0000 Zihan Xi wrote:
> @@ -19,10 +19,39 @@  struct skb_gso_cb {
>  	int	encap_level;
>  	__wsum	csum;
>  	__u16	csum_start;
> +	/* Bytes charged to the current GSO callback chain. */
> +	u16	gso_header_len;
>  };

Hi, I think skb_gso_cb->mac_offset already has enough information to tell
whether the budget is exceeded, so adding a field for it is unnecessary.
