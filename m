Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D25349158D
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024031; cv=none; b=m4cW7bwF3YzRmi5kmCZi+ErZcpOAPA8Q1D+ZOQmG13HYSAqTGAlBRYL3OObgHRs9IaM3+nMVLAy2/UsmqbAr6JFFDGDtRinFGjxZU5i9iPmKjIyrT6S3XemgfK4lzn5w5m1rt21Ygt0tHAQ7pPZlrW1XaPilvqxSVekc3/Zy3iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024031; c=relaxed/simple;
	bh=flLZILgRxV6MOvXyOHSJVnQ0K4KrHdK/sSdeDPvGUCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBCVnHHVbedgiVrTOstK06isyWRuLLVdgNDBVafQBK5ik52+KSzw5dNEy774YS3dQYQrA6//QLMR+DOjZ0K9x2o9pg9s83ye6e6ymoq2ThzpR46aE1vJB7nGvHsitPuNL5VmB+bqDuIwzZTXHu7fNz5mW9k6XOQtaE2OtpgTQQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r2MVGNst; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2MVGNst"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4d2fe2056so2110618a12.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 13:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790024030; x=1790628830; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ji7VlLhSAfjl/1tXHHTuDHH3apn48szfrKbyZ5VnSZQ=;
        b=r2MVGNstgVKsRVTHbu8WdjjFp3uQhG+gKGgr/zu2FGAHBcprwlTMeasXVW1LhsMS2L
         3X1/lwdeLXvvd7kXRfXRMtgzsHOIKO3HYTtL+EfWGuKzEFt4VxkaJ7itxxOYAAuS4wFT
         Et860yUwcJ6IPKnawKALYfo94QJBH7d44hf1DAsSruX7LCBQlBJ9Ml+81ErDNUtj5SRm
         Lc820JJ1pcFbhFyxs5VwoumAmIp+qqZi3sx9lymf1kxKXGb1RcIA6Y+Y2ps9EYSyenmo
         jb6pzIhgaKnqb8F5SpTyNYEx2uAd0uXdAe7atGnmfXoTj8pTv8anmzyLIUNkUpEyWipL
         +dAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790024030; x=1790628830;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ji7VlLhSAfjl/1tXHHTuDHH3apn48szfrKbyZ5VnSZQ=;
        b=bO/MwYPEQGhpP1nNuTEs5GI+K/tOb7FjdH0IQreIloHyby/nZDO4msCmj8x8TJedlO
         IRLtZFYK/E/smz3ut2VnYCY37J7b6wX2nb1Swt/na5X4OBQjkzw7c8NKyA8cAzH1mrJg
         pj5iPGMFtxaoa3c1l+YlH/GOxvfeXU2JvqLX3BJdZ2Zjp+FdE7FU2X186eB6swX/EpN3
         pqChPh8GC+c+05aeA8PgI/Iq19YM1fWuvLHNVy8KexD5RG+upnlXChWCVJA+tklU5aC5
         vg38NeKtgU04kmoINhJIZmZJsLoc9L9kws2xnnTsatmXNUBSLcyQrNsS026uVVlWt2+9
         58Vg==
X-Forwarded-Encrypted: i=1; AKwUvByNnMAR7KQ5GPqQdPkx3UgI0h5H5erh0jQq4+UC2h4L3JFHOOrXpwwkkrkxJjeUQ2+0fsULXrE=@vger.kernel.org
X-Gm-Message-State: AFuF++kTY7EydqR1m11Bjukzd7U4POmLL3mS+yOqgdvSlDeYB8to3vv4
	cFhUonswA1B9AtEJRuR4VZEbgGeIFMABHR0VlF0jNK0XGW3Uhk3RwRUk
X-Gm-Gg: AYBFou2+/xKyk2auKpGP/4dCHImhceCSr4PgpjDjSusRI8AX9pneSawHX9g+4ee+D/m
	mWi+rcauejnMVdN0jg9/EY3uKrq+9eBUvXyRuCn+5wZz04cv4Ub0cZy64Nt23M+8snopVDX40xD
	DqieVw/IfTJt+y7uG1w+igH743rh5Gs7Q7jqC7nmFeExrJwTjGgyHru2uF/cZhwTZbT2G7Ciib7
	xPJK/BnVcJA34PLtBd11/PkA4wCIVHCrrxpan0kJ536TsECMRQKdOFzKL8HZJpdqpK6MFd1bsTm
	XThVPGnYLhsLTdDFaZl/h/tnqw5lD5HK+5n6Cf6dbyvY4iUHwGWmOU6NI1yEiOvXWbVGEItopxQ
	9V4519wkqLglkT0d0FraO+rk6dcIicdMIhv5COx0Iwip27cFleUpEF7gTMA7AMNsy0ji+Mckajr
	iXlT6HnbeVR3wGdKQgYU+qHzunnM+bPBjmqzMS7EaLHxYEPV2ZCS5/CmQbU/LS77Bl
X-Received: by 2002:a05:6a20:a123:b0:3dd:85aa:4529 with SMTP id adf61e73a8af0-3dd8c52ec1fmr17760091637.36.1790024029652;
        Mon, 21 Sep 2026 13:53:49 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72aeea64asm3948747a12.27.2026.09.21.13.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:53:48 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: Yuya Kusakabe <yuya.kusakabe@gmail.com>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Justin Iurman <justin.iurman@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] seg6: keep room for the mac header when growing the headroom
Date: Tue, 22 Sep 2026 05:53:38 +0900
Message-ID: <20260922055338.510267-1-yuya.kusakabe@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <178994173434.2160803.11042494148021854491@kernel.org>
References: <20260917-seg6-maclen-headroom-v1-1-02ccec50f096@gmail.com> <178994173434.2160803.11042494148021854491@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Sun, 20 Sep 2026 22:02:14 +0000 netdev-bot+sashiko@kernel.org wrote:
> Should the same change also cover net/ipv6/rpl_iptunnel.c and
> net/ipv6/ioam6_iptunnel.c?  Those two files were converted to
> dst_dev_overhead() by the same series, and they still have the pattern this
> commit message describes.

Yes.  v2 covered both, and v3 moves the clamp into dst_dev_overhead()
itself so that every caller gets it:

  https://lore.kernel.org/r/20260922-seg6-maclen-headroom-v3-1-7b2f982ef79d@gmail.com
