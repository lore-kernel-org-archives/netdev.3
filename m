Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BE6415B79
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 23:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790291559; cv=none; b=i+RD2mE2LIO8BNEzn7x9ihZ+gjZShb9OEZgZrf5NLo5Jlnc2FThsnsoUd2T+/T5MhNl0ou8g2a9PNniWcAgeY9lQ/HhxgiD9KWPs6mOsgwnsRLYDJtroig7CbyPp/w2yygQNvm9FAz2IMewn6bojWaT+ShE1yBd+saR3viTyjPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790291559; c=relaxed/simple;
	bh=onzdfJe5yP8AqWaDHNi0lnlKxnpwzZjRS45z0WieHdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6FR6HpiKORzkLEt4cs8igdS3eSVgn/kuUtSoj7NDcoGrJMwMBuLTuvp89ZAgZLddjVbuZtf2rCcY92DtDeKePsCCH13rRh7m9GtiMsTNubBZzck9qJr3omStFt/ooCVcmwhpiuRILQp/KsLpDDooK6cZ3NZ4rtBF9HKLKBQs68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWrkEhO3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWrkEhO3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13711F00898;
	Thu, 24 Sep 2026 23:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790291558;
	bh=ud00PHC07sz8Dj/FlY17ay4ZTeBOC6Cj0rR86nyL2TU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dWrkEhO3lBd8TeEomrYnYgORbe/IDHSCWD57fOJQxdNmFdDlaoa10QPCzsf0qxLEj
	 7t/bmwxYPhO4+5DEtmcvoAgTKJiaJjwtsAcXTG4zOqJyJCzrFxxAcfqd7+/eadZ56S
	 sC5b1F5DQfg0QOE4fh0ITl6ZhdibH8nu+XaDuYVCMo7cTOU6x7JGxPOV9ZrLN2wppz
	 vAL+2qsoVC5+Dg+Vo5XktiiC3DNTIVtSM7ryEBzfiuBB4VaU836jNsbupFcBGP1isS
	 GrkAx0gESXk19307f2g6jTeuVeDBY+9jlC7xkgz5IZI4Gi9uiZNw0n/3ALoxF1Yy9k
	 7RT9OOQ+4z4Kw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	jiri@resnulli.us,
	ivecera@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/3] netlink: specs: dpll: declare pad in the nests which carry 64-bit values
Date: Thu, 24 Sep 2026 16:12:10 -0700
Message-ID: <20260924231211.568213-3-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924231211.568213-1-kuba@kernel.org>
References: <20260924231211.568213-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pads need to be propagated to subsets if they are used.
Otherwise Python YNL can fail with:

  YnlException: Space 'frequency-range' has no attribute with value '4'

This affects only platforms which care about alignment
so not much real impact.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/dpll.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index e2ca4df5699a..7009a64473b1 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -550,6 +550,8 @@ doc: DPLL subsystem.
     attributes:
       -
         name: parent-id
+      -
+        name: pad
       -
         name: direction
       -
@@ -576,6 +578,8 @@ doc: DPLL subsystem.
     name: frequency-range
     subset-of: pin
     attributes:
+      -
+        name: pad
       -
         name: frequency-min
       -
-- 
2.55.0

