Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A26642A82
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785137729; cv=pass; b=VcDFsoHwuVlHtD52Fb8NTzKTnPR82fNIjL/TIe0vVY2Eear0Ier+E+xeLGz/E1QGqD1mJw9TmqgCKUjiuId9qgzIuQECJfVogtEkKumCFy5Puc1M3b/bbW83GDeCLYmG0OQk7Zn8dXKgpE09E0grgIXJkci8I5lYoe6DluvhdfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785137729; c=relaxed/simple;
	bh=DcvwkzNsryECdRx5e1rnB4ZRJBiQVALuS7Q6uWqaIAw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WtiVdbQDEtUk+2l/F6jwOi8dItGhrN1afFnSorcALZ3IKnDWEt/mYOm0gKDB9YR5V51gsegSA7+eExPJcHreb18xOtmZDYcEcPBR/Snb06oh+TpIi9X2oAUA/XS+s/WexfHtlSf/pRPAOuYX9HL2OM2Z3G8CaHy8jj5j0iSGDSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwzhB+y/; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwzhB+y/"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c1600d040e4so328760766b.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 00:35:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785137726; cv=none;
        d=google.com; s=arc-20260327;
        b=EMUnbyKhJQtmyr9o8XBCthPGbLvS20iYbV+p+tsCKJ4t8PfJXPyfbSKGHz2e64sRmw
         oZMtc+3GMjBmGJWuOpdU4vxNailsDdL8KGTH7flCdLIKZBLxTYVIAFh3FqvYP2c97I9v
         T7I8BoJwRQYCEHXs/qfoZkwuMqX2YbNJFrfRaZlP0jLGUXeNBksj0fjtnQw4kmcmQcKy
         9Qgcjd3VdKyuOPW6x2gDvFssaODYg64mbYuahKClFpITv+tF3BVg9wSWUDeBEnFWzsY1
         ZhigXpHtEuJdkGewhj9drn8oosFW9dcHPdc6RbxxwrDtejHwM5Uhxoerd91KaydP/v2u
         DjMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=DcvwkzNsryECdRx5e1rnB4ZRJBiQVALuS7Q6uWqaIAw=;
        fh=nvusJKxRL3dKfbbcSF26ltGN4ft4Ntf1wzypWYZkhrs=;
        b=SCHTViwTlTEC/5SrM8xX0BBUZnUj7Mh4K+HfQ9kqJypfvcL7Uo/EdDu46tGMA8O06Z
         G1RXhnU7HPiZdI8+VDYKkPJPa2FTqid7ZISyFFlfgyjJrF12bSazDWNRuf1baRaS0pxW
         uINTukv0Y+IYfM1Qh5GTkqvVgWB6Di9eMbYAjPDcsBuPkx8bmHg6C4niOHBjJLRkq0T6
         4bPElqEkOWxBI6vbx073/9u1xXcqxKMxMfyAeM5LxAoiORP6g5vXV9CC7sJKat3mHjDv
         eg3PEqLzGaWN71bPjSwWmK33AHc8i9busX0Rh68bgdDKeT6yOLNikW8QCXlp5dFDvNVO
         DbfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785137726; x=1785742526; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DcvwkzNsryECdRx5e1rnB4ZRJBiQVALuS7Q6uWqaIAw=;
        b=EwzhB+y/H/0FpT7DMVfF1CXpGxosSCW7VDurauPIkwN7DMSl5vr+Ac/g8rjceJybOQ
         VU78Av4bSBBYAczxzDo8zwWjMbxKW024V+3lWSpRzozXVw0bC/syNpUxEX9xTgnsamtK
         0//EYMyMtUV9wmL6q6kfpnMbyu/hhlFbolp4DVpuqTE7d1Va50gjJ15O1IOfdgIG3va2
         g5eUfg1xDeyW7Jdp6p91QePOgMFi192mc4TxbD7cN1hM1XwX99INOlPhBsye5WzaNcgF
         8oSTYnS6iFm48VChmej1DP9RLnZlbKvWOtGbNvsQfXoe65hSFdrRsKRelKezVJkL1f55
         MRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785137726; x=1785742526;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DcvwkzNsryECdRx5e1rnB4ZRJBiQVALuS7Q6uWqaIAw=;
        b=AuFGk2gRFST7/Xjn4Gp26RiszXTtHy3szAkL3JPOFbE3CmVV5w5AmwY+EmaQNKg6mf
         cWAJ3zP7OExgrDXROW56kI4Y45ct/YzLMxLYagJvF0wsKvoZveURrQ6ITlNML9ovwE79
         056a7636OObhbNbaFq7Kr2He2yI0SmtV3ba9r8WNdT3dZkJXr0/YA4LestIoqHFskuW9
         xPi7GN8KsID+DlLymfWdU8v5X0kN4X3wl0vy7ehtd6sltMi+0PeJt8OHIPJ8a1l98e2g
         MPrxcm/4ZsAgunostsCwMoPX0956aDP2cw9LUalUFtGddgQeg11iLbkcVWr3japOA7WZ
         XAfg==
X-Gm-Message-State: AOJu0YwgZ02gZTGk8eG+WSFDmsPjC7BIC8H58YV9UK6cEWj/lC1H2dhP
	dJq5rgylKdyrf+EdkyHJqtSLP2rZjn1P/cWD9Ng9pNUWlOxN75Rl5PHeYf6JxJ25LbgEd8oRiDs
	u2M4XGhcxI3FBt2mfVH/4meBV4NLK31yDt9aBz/Y=
X-Gm-Gg: AR+sD13ZUsZF1xdF028FmbpSpJ4OVzNgg8+6AebnmE/94W3Czvx7Iko2eME8EGh5krk
	nCTf9uyzUAMrH/T34hZWSNeenIHQDkoOpvXhT6h7Hq8JGf0ZNMIJDijJ9JAjB4Nh1Q8QhJnT6lA
	KF0rpaNYuqoKMiBDMolXi4rJTlMkRucUVm62ZxQTC6B7mRETgkp1lUk7ucB/pUH6gZTZKZp1px9
	56vB8rLM2fFj8ealF6Fiv5h3PikiP0Kik9O9o660HHVr6W7CghJklaEdRpd
X-Received: by 2002:a17:907:3e93:b0:c12:b68f:1a72 with SMTP id
 a640c23a62f3a-c1f13597fa7mr429354466b.24.1785137726326; Mon, 27 Jul 2026
 00:35:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ujjal Roy <royujjal@gmail.com>
Date: Mon, 27 Jul 2026 13:05:10 +0530
X-Gm-Features: AUfX_mzEUHSNC1EyhyXeQ6Zf618jNeAwqYW5BTz8ZX7QXyj0VZ3DbMxNwbq9e0Y
Message-ID: <CAE2MWk=6omPesx6PyT6-ebW4dN2P+_ZfuSGPLaRiKEMznSNFGg@mail.gmail.com>
Subject: unsubscribe netdev
To: Kernel <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

unsubscribe netdev
