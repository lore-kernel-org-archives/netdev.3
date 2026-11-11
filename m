Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794371448;
	b=3WY2U5n4KdfWtwreZ6UyEBu2nwMQxTJ5OdmEvY1ktvB/gll+STHoLv5U63I0KCGrUrKx
	 1mYETN1l20N32HxNJueM3ArpCZD0FBQXI9jms7LfZXZbctMRFcS/7xnnYIGuDorLYoLch
	 swUQeJWYNoeuz3tTAMsDzrHBRFQLbGodwGwG1YSDCCmxUXWPQQ9yuXAvEHMCsj+sV+pTF
	 nqt0EptIOSJiIOj6Ucody8cNasbaA82d14Z03/7hyZ5ld5xDIMO8lECaYAeCvJPG+oJ+8
	 Re9nlyMlGmF15rvDAp+YkWfqYrW4maL+w9zlU1b6Vx7wlyUITr4uDNFGNwd5Zc1pzVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794371448;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BHMFLI/D73Ny1cZtQ3/aZEVyQktB/yR6LX1p1oYanBY=;
	b=GjtXvrP9M+KVydrddYJja/QWDZsMN2tcm9LY7kjJny9ZxMhyaFLYCPkE6N0Z7QF1gvJG
	 tXu5/BwRSm21ZIcDhszt1STaI92Jb+thHAu4kjfXfKEAyFkBp0LXSr9eqmKKiMXL3dNms
	 0BoFaxKjdj9N1AprUXxw48EjV/nACFdFt+oQax3f+Wi3BLA05/FtowZLWh5iraEcf0e1x
	 fscZ7gMkcbOdghZHUkZKWq3RZCskr1u+beigbNCRMkXT+05t6gonlYpjtXfA6U2HQ0O9j
	 8bNAGNLiiRaS2RJ7j4+TcuQMMrkGL2DIMXAHsMlrEa525SKn+NwQ7Bt5C2owUkaYaVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE4A606A31C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 04:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCE4A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a3cd071add8811f19a56ed5b684f684d-20261111
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MP, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:25033ea5-ccb9-4b38-8486-1ab69d4b079e,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:25033ea5-ccb9-4b38-8486-1ab69d4b079e,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:397065fb8a740d25022b3b1127fa0218,BulkI
	D:2611102058162GO8Z8LT,BulkQuantity:2,SF:17|19|66|78|81|82|83|102|127|136|
	153|841|850|865|898,TC:nil,Content:0|15|50|99,EDM:-3|-100,IP:-2|1,URL:0,Fi
	le:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,D
	KR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_IBB
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a3cd071add8811f19a56ed5b684f684d-20261111
X-User: kuangkai@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <kuangkai@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1678947632; Wed, 11 Nov 2026 12:30:35 +0800
From: Kai Kuang <kuangkai@kylinos.cn>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	vladimir.oltean@nxp.com,
	f.fainelli@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Kai Kuang <kuangkai@kylinos.cn>
Subject: Re: [PATCH net-next 2/2] net: dsa: user: document the write memory barrier on LAG conduit migration
Date: Wed, 11 Nov 2026 12:30:09 +0800
Message-Id: <20261111043009.97281-1-kuangkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5e7d676a-9c02-409b-9312-57bae6c0be63@lunn.ch>
References: <5e7d676a-9c02-409b-9312-57bae6c0be63@lunn.ch>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Add_By_Label_Mail_Nextpart_001"
Content-Transfer-Encoding: 8bit

--Add_By_Label_Mail_Nextpart_001
Content-Type: text/plain;
Content-Transfer-Encoding: 8bit


You're right — I can't be 100% sure the comment is correct, and a wrong
comment is worse than no comment. The AI review is correct that the
wmb() sits after both the dp->cpu_dp stores and the dsa_ptr store,
so it cannot order those two against each other, contrary to what my
comment and commit message claimed. I also can't prove the barrier's
original intent was teardown ordering rather than publication, so I'd
only be replacing one guess with another.

Thanks for the review and for pushing back on this. I've withdrawn this
comment-only patch and marked it as Superseded in Patchwork, so it won't
be picked up. The pre-existing RX-path race between dp->cpu_dp and
dsa_ptr (and the missing reader-side acquire) predates this change; if
it needs fixing, it should be a separate patch that actually moves the
barrier and adds READ_ONCE()/smp_load_acquire() on the readers,
rather than a comment-only change that overstates what the barrier does.

The other patch in this series is unaffected and I'll keep it moving
forward separately.

Thanks again for the careful review.

Best regards,
Kai

--Add_By_Label_Mail_Nextpart_001

Content-type: Text/plain

No virus found
		Checked by Hillstone Network AntiVirus

--Add_By_Label_Mail_Nextpart_001--
