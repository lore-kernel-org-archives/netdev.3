Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323A034F491
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093890; cv=none; b=oHkhFpIVxOpe4rm4tgc2APVXc19Mk5QVqnK7JbLn1fqp5OiuhzAcUtcwVwCLoFUP01O3QSTtCexUN9GbfxpELeBSVUBROEr5VoQOYVIgrwxF9LiTRpPrQ9jRpfsYx6GsW65VHhhKTOqSf3Rx1guphI7+jiqsdbLsVBvAip5FD9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093890; c=relaxed/simple;
	bh=Jlz2/1Bx1coasj7S4+LNbHVkYJCwS93f7tTbNDuk7Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHKnm9hrtXMaRf/kfYEit5OtnXte9sD/CfIqxo8QDy78+hyooOIGDiBi5x1WSP7QUHXpjdjL/yWmb7LcdvKqO6QUuyzqHCewSlo11/s9g6xQcYrJKW6PwNgjWoj92ji6MKwcjXCDCpvho1wHVmDRBYkHGhceCuDhtQLi9LIv7z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dru122bQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dru122bQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769093888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dye+FGYvXOO3gygAE19zVF9hEGT9VG48qOSR9Jg++Vc=;
	b=Dru122bQM1KU6W7TAmZfoPG753qDZgQ9CgLrful4FiPex3fy3iM3EQf0vwtwDb4MbFbVPh
	MhsCYAPc8j1V6JSJefCj7N+jYel3Uc7Gym0zI/bZ0AtJj2uliI0Z6SjBq7q2huGJagdHgm
	MVeWoE1u10qK3X9ifpy/ALYhoO1Hikw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-x2c0u39EOBKP6gBP68aSxw-1; Thu,
 22 Jan 2026 09:58:04 -0500
X-MC-Unique: x2c0u39EOBKP6gBP68aSxw-1
X-Mimecast-MFC-AGG-ID: x2c0u39EOBKP6gBP68aSxw_1769093882
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4DDE1800370;
	Thu, 22 Jan 2026 14:58:02 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.45.225.113])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 768C41800665;
	Thu, 22 Jan 2026 14:57:58 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jkarrenpalo@gmail.com,
	tglx@linutronix.de,
	mingo@kernel.org,
	allison.henderson@oracle.com,
	petrm@nvidia.com,
	antonio@openvpn.net,
	bigeasy@linutronix.de
Subject: [PATCH net-next v2 9/9] MAINTAINERS: Assign hsr selftests to HSR
Date: Thu, 22 Jan 2026 15:57:04 +0100
Message-ID: <ee87306d3cd04b196fc337031780bd7850fa19a7.1769093335.git.fmaurer@redhat.com>
In-Reply-To: <cover.1769093335.git.fmaurer@redhat.com>
References: <cover.1769093335.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Despite the HSR subsystem being orphaned at the moment due to the original
maintainer being unreachable for a while, assign the selftests to the
subsystem for the future.

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 92768bceb929..6cb87b640ffc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11582,6 +11582,7 @@ HSR NETWORK PROTOCOL
 L:	netdev@vger.kernel.org
 S:	Orphan
 F:	net/hsr/
+F:	tools/testing/selftests/net/hsr/
 
 HT16K33 LED CONTROLLER DRIVER
 M:	Robin van der Gracht <robin@protonic.nl>
-- 
2.52.0

