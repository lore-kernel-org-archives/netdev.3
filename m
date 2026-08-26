Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F92444713
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 22:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787781897; cv=none; b=jDcFQNFz4BCSO5cCFZ5NHQSKEJCwS6002Xm8rL3AHOpOmoSdl7tBRKQmKDYkftnpGsUZpwT/YctQzl2NklNqgIONpqPAvhBt/EErmTvhsK/RuuxlJ2Iyj0ioeQyDDUlz+ke2hmARonQlOZ9IeCs96LbeuX5du5qg4PZ8h4CI4Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787781897; c=relaxed/simple;
	bh=avWavNZj+ROQsclS9fDyynsASSegrDqu/qCZGFh8iYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lz64NrC4b1ZIDY2tbJ+KLIFpuajzlGO835Wed6dG/8MFsnLKBaTjcBZN44w8NofNvPmGbgGCgBSMx3VBevBfMvixxcKN4DE4AFHrERF/oIzZ3DndSRtd1IIyeppg+O+1Fn1LSrEgotq8XcsnqEJysF3QzeNG863Ugb0VLov9pic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-47db714766aso259096f8f.0
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 15:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787781894; x=1788386694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+OIG0D3qhm2TUglRdX6PNbg8gac3xIElAw7x8uuU1sI=;
        b=JTpYr7T7Vu84kaCTYtBSJc2wP1n0oeg3JsfknEsJENPVFW6L0v2+shKs8d6a93Rmm2
         C1pobDVQsrdnCIMCQMPmqA7VT8aKRxFTyVRwLx2FkNj4I0mFJQg2AfxV0zdlbr+4kYxO
         OHMKmttjxkB5JkVX/8iXVf1nQRymjxleug/pqhe1a5eluH1J0pVoeqyISq/Dx50BzBc8
         0YVIFQIr0E2hZWmYzNGvaBniD/0wDLkKyVL5eLwfHIYWWsB84z6u9wZ1JcJjuUcRkiKR
         NvdvjUkChdJRJBZnOwIRYtrVR0vYJHdaeZTrMA1wfBr7HtZQscIHQeuLHw28Ms6wDtSZ
         bY1A==
X-Gm-Message-State: AFuF++nyjj/sl92iuyLzZDS+HalJateC0bOHyc+G10Gt6YU/uZAG1pM0
	kBYZdgX2G4RfLEaxMsS5s77UDyYa3VU30CGzC3wa8mYA5fr8nB3phRP5iue+x/Ai
X-Gm-Gg: AR+sD11K99EjnhHiv3h9ObnhFqVcJ9Pobnwh+6njtL1bCIXrBK63OWAwERXJqvgFM7c
	f4AjaOkJOCfaM3Jzc4w5SnM1PtrZ7vX4TXi1NDiKmQvw4+HTYCRfYr1ZWe7QmyYuvFicYl9eS0v
	SW9q8oNM/YwDozWZhIgW2SXIQ1CSvDV7OBHn/NGfk+BbxwQDOT+Rg5pG1e7I2L0t6fRJel6OA0H
	I34bC5ZNDL2KDc669CFA4/2C4Sxm6/UP5Y3nsiepQ6m28DqApDyUIc6XcKwWzwcglXN36+y1qh1
	ArJeq5pNn03isc9VTK9jbOg2sLmiPe89gRroZzD+q8+QfujAUdx9qORVRi6CXwb6eCZP1dq2ZiP
	na84bY7EZTrCoVOSMbuwgbDwD+QnCsG0kXaZCB25TQVYw/Rsxzw2s2ly2XVYOyxTE+Af/e8pvak
	ttCrs7sCx0TDUkygBNyj61yY64v7VDxf2KmLlO7dAsfofREwLln8S37ff4hKIxB+bCX8bmc2VWa
	3YgCGrIO2Axlj5PmA==
X-Received: by 2002:a5d:5847:0:b0:482:dd86:348 with SMTP id ffacd0b85a97d-482eab6a866mr2110147f8f.4.1787781893856;
        Wed, 26 Aug 2026 15:04:53 -0700 (PDT)
Received: from im-t490s.redhat.com (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e27a9f0esm4446370f8f.10.2026.08.26.15.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 15:04:53 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net v2 0/2] netlink: specs: fixes for conntrack dump filtering
Date: Thu, 27 Aug 2026 00:01:10 +0200
Message-ID: <20260826220444.4054714-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Version 2:
 - Also added missing tuple attributes for the dump request.
 - Converted into a set by adding the patch 2.

Version 1:
 - https://lore.kernel.org/r/20260825155832.3685714-1-i.maximets@ovn.org

Ilya Maximets (2):
  netlink: specs: fix the conntrack filter type
  netlink: specs: add missing mask attributes for conntrack dump

 Documentation/netlink/specs/conntrack.yaml | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

-- 
2.55.0

