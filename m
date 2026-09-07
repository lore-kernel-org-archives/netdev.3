Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C30486650
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781332; cv=none; b=gvzfBmcdbss8pAdQ/iH9rwhAPNZB06yxYLRLRWGI5Pp/sEY+VPV6Cg8k8ETmfQhWNUsMax8Q6e8hOsscSDqIXyCzF5uRo9b14lj+J3l3CNVHJ1Xe2WN0A6HoHtjl47+K0c/Zb/8QTVKRh0Yqak9V55kjYCjX3y9JchfQq/ClWWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781332; c=relaxed/simple;
	bh=C+eLPiFi9WdfK84iABK0goOyBk267bDzFYY1gpNX4aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jaqrwuo6fny436ivA6TJmGMnsmdtPD0W+QEGRx3ynmMHO+iuPYZ6UgWxKOZ7r8T6oPM7j3gal9GL/SU8wTQM8qwhynujaVrzeeWKpIDbesJ2aFxsY2SIUIt8At+U1gCvnRiO7H38/QK4XAxjBlRPTRm28lDyQXkzCRoe3D2DbZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atApHJdc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atApHJdc"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d9db539a54so27141265ad.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 04:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788781331; x=1789386131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8HFlAQzgEIbB8YVKSTeZ2MR1Rp9Uw4tUj/0oWZttTjE=;
        b=atApHJdcxcTPpV3AStHKq1VZy3IRPqVb1M4iIdEpSJwpjPlui0Nh8HHrrat/VbDlWl
         nsr5CAjnR4lbdYPJdMVFPvBP/gm1n7NorHhRqGxfDNYpYgZoY7/oR1HFJaIrf11hWJOX
         /s0FCWFkYnFkvYEML0biWszJezI8tq7dS5TZeHsZWCz8dX6ug+Ej5LZ+e0Uc5vB828Xx
         BlOzAqRkjPum7NIQBRqyWKvJBNZMG6OQhxNeOGmk+3gIcKzG/5tf1iSpUaE1HuOC0vEY
         6PqOz+6PlZj7Zy/ivlepE6Wb0qhF3poVC3aZuKg3jp5dVWtlXMynrgMXevwJGf5IiV+6
         uVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788781331; x=1789386131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8HFlAQzgEIbB8YVKSTeZ2MR1Rp9Uw4tUj/0oWZttTjE=;
        b=H5uswd1nuNxyaTF8kPD87wpJYduhzdMc9n9kkrVA9eMzf4kCl6LYQnwmTqSUqXC593
         /d+4YwYAWu0jC4LaDASjalB/Q5y0EEcYjTsEoi809g+rnuQTvYpV+ZweKaty5tRf+E39
         MyarO7TrTRSHC3X0oitjffRJxbo2euC58TLxOiBGZtL6sv4hGeT229bVlYVMLqpnTC1l
         cisIdBi2DqbHYxPq8KU1TR97ibBK1C9YXaVNurVA8pwFwwF3f+XJ4QkavXHo6GE0Ly5D
         ZCFTE9H5chSRohmeLFMQ+W7AZ8rTjU0I3h1LaQlkAbGE/adiQTywpbsdfzJxudsBgBsn
         wN7Q==
X-Forwarded-Encrypted: i=1; AKwUvBylzrZpPZo219jFS4lJ7X02xk49glYqcjpAR0T1Sjcckqj6GE6EO5hFy28t76NQUrhYfBV757U=@vger.kernel.org
X-Gm-Message-State: AFuF++lCr2Gx5ThlTAOGBtVw/4l0s+QHaTyW0UdiZ+VQpFOo3lyTQ3pt
	vITCx07aLXtlnPxQnY5GUvdulppRB6XwLrgr6vi5OaeShGMgVL5d60Ld
X-Gm-Gg: AYBFou2wJzqZ0SMvmxsxwVETxJ23EdvwmtrqqCYdzzV4IPznqT0VJxAJwSsTqli12il
	+CmnWZ3G+GqhAwFCXWucV/L3p1vWn0SuJ7+9SgFeTqjySixpGsO1GnLSVoKilbiOzyC/UcShfp0
	wA05j4bHcoZGDrN/2bPAtB3SrD4pthLf18Q6cllBW0Zdv6Cs8LapvBeK7Hln0ADbT+EyY9b26xL
	d0a+cgsDXw05/3toxqqiRFy5KfDBe8wuz6UBr8YqgFnj8lhGFrQ16pyB8kP+Yjq5TMOvgFO4gnv
	4sqNfbppyVWO+YQUnac3Bu7hkzdvWxkp69XD/lPbcMTPVpdBkU4JH4lBtF9yucTKyVkONjl2z0x
	D37uVedvqi639KYx18Xc6MFh+kKXgF3ZU6d/3P2Q1ybirIFckVcyjDA3kONdewryKzbML92xH7y
	0xs/o0QlP1I+1Lji250aKDmZ744M1PxKwZYYaaRyfnUHcvL6NXtYYVDi6clxirG3QSC9I2eyNri
	YaX1tawrxTErQ==
X-Received: by 2002:a17:902:db09:b0:2db:5788:655d with SMTP id d9443c01a7336-2db57886668mr77258275ad.22.1788781330592;
        Mon, 07 Sep 2026 04:42:10 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33825669695sm5249874eec.3.2026.09.07.04.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:42:10 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH wpan-next v2 0/2] ieee802154: fix typos in comments
Date: Mon,  7 Sep 2026 17:12:02 +0530
Message-ID: <20260907114203.40171-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <87pkypwf13.fsf@bootlin.com>
References: <20260907095132.21244-1-hemanth.selam@gmail.com> <87pkypwf13.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 07 Sep 2026, Miquel Raynal wrote:
> You should not have dropped my R-by tag though, given the fact that the
> diff is strictly identical.

You are right, and I am sorry.  The diff was unchanged, so your tag should
have been carried over.  I rebuilt the series from the commits rather than
from the posted patches and lost the trailer on the way; that is my
mistake, not something you should have had to chase.

Thanks for re-giving it, and for the note on the split.  I split by
component because maintainer-netdev.rst asks the prefix to name the code
being touched, and I could not see how to name both drivers/net/ieee802154
and net/mac802154 in one prefix.  Abusing the prefix is fine by me next
time.

I will not resend, as you asked.
