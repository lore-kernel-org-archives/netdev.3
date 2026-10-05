Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D294374E64
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 12:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202765; cv=none; b=fsrz0kOFJRq7n6Z5gmY/U9CrwkWqj2E9uYMNaRyZPVMDWOmhH4wry02xYHINbrabWu4Bg4qjEfkAWlhLxNYKzZ9HiAq0JcIPmGSbqk0Pg8QzjX0HCGx6JypDTFz9ImV82W3Do+J66NvEeBvk5atI202HWCZIBJ4ly6smY59u2+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202765; c=relaxed/simple;
	bh=WvcZhpPyG5vqH/W9xhM3lhuLOlqBjjaQC5+yGLvVUKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocJAn+FJj8xpVvtGSn5dK4A47a7w2IoGVwAAga/hgVZJsoeMW7IpYAnOOW8clN71/xvhwSbV06v3XYC81NPwoQW6uptAeNjqLNoCUJS57hSl2GkKr8Nw1ry9bRF6Jc9kUIC9P1NjYsbJc7I0s//k1j56pwZPhmXqjPgW37f4Tyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=G6bamAyY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="G6bamAyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED081F000FF
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 12:19:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=G6bamAyY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1791202760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WvcZhpPyG5vqH/W9xhM3lhuLOlqBjjaQC5+yGLvVUKc=;
	b=G6bamAyYsB5Ksz5LwfDnsxHU/bQ+ZsnIJNLnLFvTttMNhpSkb8A9lI33Z4GSv9b/KxrxwV
	0gXhI74rvG5dSoqoYGL4h2altrw0H0NHZEWfEP9Xb59M+nmWAZ4MkxbJfQPqxbqUH/T9ET
	hO6yZGGhXsVPLK322Pup6LZnxkj5xBg=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 5bb2f698 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <netdev@vger.kernel.org>;
	Mon, 5 Oct 2026 12:19:20 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a601ba6870so2848240a12.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 05:19:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzlwY0nJOE/n6lUXLnasEdndoueYeHqo0vsPCwLRhXOadGDbmAvsVDU45ZlhpMgLf9Ea65Zcss=@vger.kernel.org
X-Gm-Message-State: AFuF++nHCpE0DenU6amr8AonbhA6ruO6DmZEIrdyYlEukmmhB1Pl1Fwt
	2BjOoIBU3YGH8v4RVABqsrUnP8++L1F9B6YWsA1Kq3kaOW2M/AQdA/6h/RyH3jXpAFvsSaxGjfK
	Y0kBGqLHOUX2UlcLIUVAfSupoA6GYIvM=
X-Received: by 2002:a17:907:72d5:b0:c2e:4a61:d436 with SMTP id
 a640c23a62f3a-c2e6edde748mr623236866b.36.1791202758948; Mon, 05 Oct 2026
 05:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TaZxFNfdnpo-3szeC-LoWZBxj-6XGhXkdEqnQi6yyaOHXp8cw4Xtksw07sYrIpludwvJQrukFoCGw3r9rXDcInkdB5QD2EswKPNsXMU3qMQ=@proton.me>
 <179117435281.434549.17747961185403870914@kernel.org> <9NzB3VmT-7cBBfdx9sREmRkFb_gOAmI78VheKlX2Mdiqjl3B3N0OCZ5DT8C1SpEJuM5O3TzLltSpGh9ptxni28Lnq4ATz8u86R-f-jdcKPE=@proton.me>
In-Reply-To: <9NzB3VmT-7cBBfdx9sREmRkFb_gOAmI78VheKlX2Mdiqjl3B3N0OCZ5DT8C1SpEJuM5O3TzLltSpGh9ptxni28Lnq4ATz8u86R-f-jdcKPE=@proton.me>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 5 Oct 2026 14:19:07 +0200
X-Gmail-Original-Message-ID: <CAHmME9qod-kW93qUPE14ABA3sKnoGjtxwpa2m-fXh1PwKXSOJg@mail.gmail.com>
X-Gm-Features: AclHuK_FiYZ2cjeW---uF0rLHUyrzdPaSzCXM36vgNi177Ug3AGAr-kDQIcccLA
Message-ID: <CAHmME9qod-kW93qUPE14ABA3sKnoGjtxwpa2m-fXh1PwKXSOJg@mail.gmail.com>
Subject: Re: [PATCH] wireguard: allowedips: prevent stack overflow without DEBUG
To: quantumvoid0 <quantumvoid0@proton.me>
Cc: netdev-bot+sashiko@kernel.org, wireguard@lists.zx2c4.com, 
	netdev@vger.kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"

This is not reachable. The DEBUG is there because the point of the
selftests is to reach it, but not for this to run in production. I
coded it this way intentionally. I don't want to remove the DEBUG
test.

Jason
