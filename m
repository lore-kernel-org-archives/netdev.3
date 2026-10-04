Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAC21A0BF3;
	Sun,  4 Oct 2026 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791147625; cv=none; b=aNhWWGVVwLc05zBKoGRYuhjr1w7wB7oMPfMAqQ2k7wUGlT2OOtuAiHlZ0k3JhGKA8WApZVz16dWjmKBRIrELXcf+tPc1I6+ZPQtQiWztzzKQ68dHhOHeny/VVRcRbcrZAPB42b4q2fQkjQ8euiVI7a/exZx787D5nEmaHMFsprU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791147625; c=relaxed/simple;
	bh=/bh40JKmJKyuyowJmgxzha9FmerXUcJGFYSmmOUJAoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Az+9DhZUISr5j2AIMYbVKLCk1tHc1xFmsKsIVZ+hBFT8UKI7b9eAbT31FqfYYxknwAq1TW4fubgrv6pRPB4VRy/U7V4R/OsP5W7SR+7RtnsUfCdddTAMQM4l2D7jbeeZIPlUQEPHtPQPEmeO3/if4snYh1T6d5OguwluqdUjKqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=oQup0mLI; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="oQup0mLI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=llyZ4mngt6YFwifYkpZXnA+5iQTIEo/CV4ajIkldoFA=; b=oQup0mLI2DMvnxuSxeoRt52suA
	0a0knfUmG2wnODHW+w5hY8Cqpkn0ybYy6rM00kj4TKkkAgR8brC8hEZniY3kguHaaVJGoDcx/4qEz
	4woDARh4FHlaNWDyWU7LGqgBnqqB4aHW58u3lXXEktDZHCjlAz7+Sr/Bs6OtUETuMidYGMfw/RaQZ
	/FVVZkl2uq/4CspbSIwtWq97OKiPMghVogmL8DOGPYE5prkhJhoOAS9ktKOgoStG1NaGCojUnV7Ex
	mO49QleCSkq12P8KTJjUGhyKoZ5hOHPkwcslBcCw7o9Txj2NMWjsm0bSK8c2aTNGK0kvkNIdN3UNg
	k97hSc8A==;
Received: from [151.115.150.205] (port=43990 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xDTJl-00000007JF1-2rvh;
	Sun, 04 Oct 2026 23:00:21 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	Jon Maloy <jmaloy@redhat.com>
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH v2 0/2] tipc: fix topology server teardown
Date: Sun,  4 Oct 2026 21:00:14 +0000
Message-ID: <20261004210016.3051310-1-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

This series fixes a connection UAF and a NULL-socket dereference during
topology-server teardown.

Changes since v1, addressing Sashiko's review:
- Add guard to con->sock to fix NULL dereference.
- Walk forward through conn_idr before draining the workqueues.

v1: https://lore.kernel.org/all/20261003192530.2414682-2-Jeremy.Jean@oss.cyber.gouv.fr/

Jérémy Jean (2):
  tipc: skip socketless connections in topsrv teardown
  tipc: fix use-after-free in netns teardown

 net/tipc/topsrv.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

-- 
2.47.3
