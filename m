Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D7B476040
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 21:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791150190; cv=none; b=N609ZIeUUiyMU8uo0NP14XYQfRG3El/PJmbNY7AMo297/Ld+sus+hbHxsBze4LpPLc83OoaRYKVqm3BFf/usQkQPnLjOgteNMcjvdh4t94uSWAzSM1tKT80jTnxO1dcaeqKS5dTrtWA9baZesnRJfLUJyOOpw2fpHbrSVJ7exIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791150190; c=relaxed/simple;
	bh=ONQ3/fm+VvJcbR2hGlWWmoJvTQ4LkcEql3G60OArTd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLQVOVgDTpbKY6Ab4OO3DD5V+CDTIslQXVSODveMOBiYGh1TpIJPpgPV0tUVKcK4D8XsPddQcbDvH/wIhs0QqiyUF783d9AqZcv9AGvJBTCvlJzsO/eo6SLpY9FoAx4cWh+IAeMgjUw7Nnfh+Ezw2oZba6aGZRFKiV3SWty3P7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tw05ZvwO; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tw05ZvwO"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48b001cd92bso579877f8f.2
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 14:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791150185; x=1791754985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=44L+w1lo0aEfL1hM5su/VJjhXTZhdo5HD8XfCtpMzH4=;
        b=Tw05ZvwOODV1gx+0jiHCKped/cJPi82G8/unjkIEmDya/VLQZKaBXscApMH/ZHbGBc
         HrfqA+4hy+nXSBpR/NBvRa71qLYUzVBXZiJOKB9QujsOG13gJo3O0RvPBA7LHLh4UHY8
         59kiD3YQrCjUlAIX+NYoozOqpc9Ll5oLHIzngtxwbhkVaZJtekABeZXchxpJvbvncP+Z
         Tw5sfa4MRj5drP6/+hRFjUHznlyeLzMc+1NAtBDRx+MVDUVmFrJCdn7dtVFj5X1dTvJC
         rwk4/io0813IUk9ESbIa9EL1i/WtkIt99av2M94TNqDoOUhYvVLuTmmiSEROhO9kivzg
         no2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791150185; x=1791754985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=44L+w1lo0aEfL1hM5su/VJjhXTZhdo5HD8XfCtpMzH4=;
        b=D8iWTL+CpWMg4gGd/MARgeiZme7YzuvCHMfycGZ6ZjeF82fHDjvxlKQ1vihSb+Xb2S
         UIq7Lf8iWNHJAae+KiOmQamPdik/7QdpWsT65Lomp98HuNXGJ3EDkYglbRm6RO/quKrR
         2c+kcAMWsIvN9q5Af9Q1caI2TEy7zsXqHXcj/hW3yEctxVP03fSNr0CL2o5ID19O6Nke
         AR6iU7ZFVD1UnJnxJ5BEukH1Nj6XS5j/mocvsUsjMmySz6EWJNDfvqqsOf92O/vioY8N
         zi2ncd8DicO+eiICvoXiTA7kU1OKuJBIsfxwpGwgL3C/+UPab11yh+mod5r1xzBSe7H9
         5mTg==
X-Forwarded-Encrypted: i=1; AKwUvBwaq9pZN4ZiPhGi4FjJNA/ExD4o3MlftMz5XMbZcuqnUPzhfI2LhyKz8aVC9vUmm9wp08Bt04Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlRpQxESNoRD1pwjek/YaxW5RUL1+ziymWEx/IrN4OeBmhZjgd
	vjM1Mkvr7UsSTMw9kuErv/oElLOrUcRFEy4VGsuW82HARVE4ealPkTTm
X-Gm-Gg: AYBFou1+7cuU9m2VC97cHWZHOaavzw+go/Xek7swAQaJ6mfQjq5Kk1u1d9i2HW+uk2W
	LEoLEujVfqMnlwKjj109JsHX1mZjKUzwjNwd+TtcLssLxY3Hb93x9YxV55U6vCLz0uLC+9Csxu9
	Zk2w9nd0hbwyEG1rYXQ0ZYMxg6DbtzddL2W5vEqq3vfLyk0QO32EjQCM0qqsZK1p4w4Zo3cj3nN
	HNbdJlxNuicLAOzFoEPMGyOiVGVD12TAgFpQ97Sd81tM+FWXyMlOOxKa6//8ROO3miSkoH39NwY
	MASkjScp2xLRKCR1sk5I/Fr/pl2uz4kmcsyr/apvJSwTp17nZ620MLTDDpTwhQpcgojkFDQxuQK
	imlS//4uTGS8s2R/M+TjNl4+xpoibW5q/gDk1ujfePgZXvxGhRFPfpD7lXnE/DrUrDx6nvj+ij8
	PMeiH0rDpTRYrjhRh+CiuQeDHLvnB/fXUxYMj+a3AsGrPxO5KAvj/Nd1um/WxOKzDNhiriLGA7f
	h3uZpU83rhzIX4x6+eeVjdNl27H/LyEYOIUZZzuu3gM61TnMPQi2TNxncWS
X-Received: by 2002:a05:6000:491b:b0:487:834:9307 with SMTP id ffacd0b85a97d-48c48023772mr8504789f8f.50.1791150185325;
        Sun, 04 Oct 2026 14:43:05 -0700 (PDT)
Received: from andreayoga.localdomain ([195.122.200.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38104e07sm19331801f8f.31.2026.10.04.14.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 14:43:04 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Bernhard Thaler <bernhard.thaler@wvnet.at>,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH nf v2 0/2] netfilter: preserve bridge egress VLAN tags
Date: Sun,  4 Oct 2026 23:42:51 +0200
Message-ID: <20261004214253.5432-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179114935323.1402591.1020652042294576959@kernel.org>
References: <20261004212429.3648-1-parri.andrea@gmail.com> <179114935323.1402591.1020652042294576959@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Oct 04, 2026 at 09:29:13PM +0000, netdev-bot+sinfo@kernel.org wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

The issue fixed by the first patch was found by an LLM-assisted scan of
br_netfilter. The issue fixed by the second patch was reported by the
Sashiko AI review of v1 [1]. I then confirmed both with a reproducer
under virtme-ng; the reproduced symptoms are described in each commit
message.

[1] https://lore.kernel.org/all/179084999520.434549.4764913674478855382@kernel.org/

Thanks,
  Andrea
