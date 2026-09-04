Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB8C23A99F
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788549032; cv=none; b=CKYNo8RiiM6BRe+vndnDc4shS25Yk+4o2Z1dS2ETW7fUS8pQ1DHDzYk6VyyQCXMjyW352CPe96VMuInLzbIm7Gu75sYJUiLq4leqn9LkPeW92lW/E7QgbZoaXnpCguCx0fxM6BhH5xSIT9xEUhRSxX0H2KpUcoQfIKyyAwaa0bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788549032; c=relaxed/simple;
	bh=xuGPqUuFK2D8burBoVOh/m4DTRwuzSrM0dvPA2zF2VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U4o97H28kGKS7Zmy8rUEfjNfShNBmlcEoPSX6brcjBJvRfjV/W9AfQNL53g+GAErX7f6Sl5cYcAaVeqXBNF1YdDZObz8efdqauTHeK7i8xanPhmXRj+9wAArO9rPAEvzO4Cd/eCXrbGMTROV6DaKBWNcemuetOLNNmB7VOh7wOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8Lw8uuR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8Lw8uuR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F93D1F00A3D;
	Fri,  4 Sep 2026 19:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788549027;
	bh=hIObroaBcuTvsGoFV6Dec7gnmbnXOBUF7VLi/UJbFig=;
	h=From:To:Cc:Subject:Date;
	b=W8Lw8uuRHpua0r10AMTzts10Qpi4CBNYbSBin6A8J1svhsPYr765IpAHUq43t8QCI
	 HAl+IhMWTNhloknQpfvHTsp786jiGkdq6QHIQZ0gIIVnHHoCq7K7Q82+4SQRPM33LB
	 7Xjjkr7IIN55HapQdzSm+w8ZQIlZNqTfQegyZiBwvUpugr9thKHh575CQcKwOofA+E
	 IOkECs8DqanTFFKYmstXolwpk9ugPFI+HCSU9g/bi3ny16suyYAaFLJxr2A3NGebkJ
	 k3TjY3jSXqDQhDIVpl2hv2tWuy+SwwBxciila+77Uvnk9mrQP+U/hkR0h4bkprPPYI
	 qP/dTwvzbLscQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	ivecera@redhat.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/4] dpll: fix lies in the Netlink spec
Date: Fri,  4 Sep 2026 12:10:19 -0700
Message-ID: <20260904191023.3869690-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clashiko started accumulating pre-existing issues in specs so I did
a scan of the families. This set fixes issues discovered in dpll.

Jakub Kicinski (4):
  netlink: specs: dpll: add clock-quality-level to the device-get reply
  netlink: specs: dpll: drop the pin-set attributes nothing implements
  netlink: specs: dpll: pin-get has no dump filter
  MAINTAINERS: dpll: add the netlink spec

 MAINTAINERS                           |  1 +
 Documentation/netlink/specs/dpll.yaml | 15 ++++-----------
 drivers/dpll/dpll_nl.c                | 20 +++++---------------
 3 files changed, 10 insertions(+), 26 deletions(-)

-- 
2.55.0

