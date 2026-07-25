Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A3B2367DF
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784941093; cv=none; b=NUfk0iwblWhobVM7ADvcaKzHtVu/cGEv5tgsPTnP5Ffp39Elrpifb+g/fomgIVm58ZKin+EKe7psSMWDFafaZGXo/bWhBrlMmpa/srqSRxoa8GDMWKq6dORhzaJhtFyvsJbPhlQAJ10ScJklcH7gee/kWfnY59cKn8E6OWPIbOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784941093; c=relaxed/simple;
	bh=kuTSarj9ZfJEd/4fshM2vXhKd0SE7Hs9HNHQbQ1dtwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oG0qdfNj+HtTj3Lv6lzhJr36+1oglLyk8ffvtK8UXbJNaZQbkrATvNDYMHpHaLTLFzJpCtjLEvNwXa6DT9tr/8ccz8i2tCTvID2Qfsl53Fxs0NQyXSMKr08425JWXwouXfioFf75QfoVxOMvtV7XVThshd2aDc54hYZU7lSSJyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyeFUaVG; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyeFUaVG"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so1070483b3a.2
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 17:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784941091; x=1785545891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3RPSKOAGTuMe7DirYFHsiGB/35uTeF1WdVdXjVBBsZg=;
        b=fyeFUaVGEb6c8p+RLJ6dR6egto59MbbQvWXzBF42H9f6TYc5viPCMfz45lA/W8E/9a
         ZkKPimF/+BgGAQnC7/CUF4QQZN81GuhSkHWsLNgTSWfpbZe5/MmCHJ+agFwwsEl0H0kA
         +pswLirVQSeB2P+JqUvGV6NrRl560taQkMvIUgEQPUrBgFdujUlFlcEqZyC2okdbm83Q
         fzguk4b0EZqxr4g/YBpD7fjMRf+G5q0hPeIpOYQuturWpYuzS00glBE45oxWGPBlg/wO
         3O08Gd/3Ti8O5gKiO3nbTQM7ArDpguwemNFz2Mpalttz7ubjUp3CiQSZO257vfDXh8Dy
         OfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784941091; x=1785545891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3RPSKOAGTuMe7DirYFHsiGB/35uTeF1WdVdXjVBBsZg=;
        b=dbGCLopcsi2MUFylUEElg+qpzfVtHDJvxCQeEgD0bVXho1oP/KXyIJdZLAOQ3MPDFr
         UBLwJa3ioPH+hvY1se501+hTdPkO5V3SvTBUXCRO6v1I5tY6py1iMoCUPJ0U1zQ3a7ZB
         2e0MgfOMZctxJZmJcUeBe6++Q5tFo5H24A5hUUImK2yJUpfarfAcqWvuUK1YAMJ358D4
         ZGjyiP0a1sjT7clL/kFic31IacoSxmKuj0xxibqkXRLBNOAEoebM7NKvzVlCbIL9JDXE
         BzeVkhoUzgwY+qhjPzQulPwl/dLavFD/lTdl9ZPjuOFD3evhJHRORo3D6pIiq3cviHve
         QuNw==
X-Forwarded-Encrypted: i=1; AHgh+Rrv25nkd1ItnKxQhIDpslKANf7hF3AT2+vO6BMjM9z7melKmNFNh3jSU68tlxlhrhWcuB04CDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJBBLY0z+Qdj156eAECY5yNTHcTSezikeu/AbKBGbX83XvgzL2
	QxFJXTZ/qP01VyaQ4ew7rJryfBxpBxaDBi8JiKinUYqQMHZL9tMGbTyb
X-Gm-Gg: AR+sD11UX+l4I+KMMUYTlbXJ/VBJXYdHHY/6bpWuPyuaqrTzQO4JJcDAPYvgWc8RlT3
	79vVVLUEuolPI9Ltl5++kWwjQIBD0ZPJ3Tk8lRzJkHphE2O6zqmoS+pkjM20O+YH12RgFWD7iY6
	6xOGXOU8TodqknljLIvb7W3eyLUiNq85y5QI/2G7g3Gd2K7YQQZCtVkdOQtyrRQakqF9PRJcFuO
	gLmAbTXexjwhuglk4TpnNk8A0gbkgje9F/0bcyAY2OWMLy6SJTnElnWhPgl/NQa9mbZd9/3cS+R
	Ek4OSv8GUUYDlAQaNn5ShiHjBhCarmziLnZAHm4eLCKyc2mF4NZZvBvdpN98S9FQUK6KYDeRD74
	pFpOgBjTy4ow3xLC+FSfTJeaDRGQRhoXt5OOXUNxIXAvj9CGWN69yATjytL8v6CVN2ZyV797x
X-Received: by 2002:a05:6a00:4c07:b0:847:df4c:40c9 with SMTP id d2e1a72fcca58-84e595543b9mr406839b3a.46.1784941091167;
        Fri, 24 Jul 2026 17:58:11 -0700 (PDT)
Received: from localhost ([2001:da8:7001:2000::1:5491])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e53254f57sm566254b3a.1.2026.07.24.17.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 17:58:10 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 0/2] riscv: dts: spacemit: Fix phy id check for the phy
Date: Sat, 25 Jul 2026 08:58:01 +0800
Message-ID: <20260725005804.373698-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported, the phy framework can not detected the phy id correctly
when reiniting this. So add the phy id compatible string to the
etherenet phy, so the phy can be reinit successfully.

Note: separate this patchset as two patch for backport if necessary.

Inochi Amaoto (2):
  riscv: dts: spacemit: Fix phy id check for the phy on pico-itx board
  riscv: dts: spacemit: Fix phy id check for the phy on com260 board

 arch/riscv/boot/dts/spacemit/k3-com260.dtsi  | 3 ++-
 arch/riscv/boot/dts/spacemit/k3-pico-itx.dts | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

--
2.55.0

