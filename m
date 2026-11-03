Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793687900;
	b=xwICliqwOgFwpQu3uvMSpjWX8vQw1Uya9h5KjuP2IhiHJE8JXPwc5vfXPOONp04Wbk2v
	 MlBpeFsJle87bmUCmJKNAjN0hjdlvqtNNnsf14QudOm7hPZL6XaKduZ4llUVzM56BnmCt
	 USQFgsRFZemDlbjjyDm4yTqWQ43JRTMzgeIXTMno7/Tqs9O/zQlPqrsX/MbQhcRJl6ZTn
	 8NWbGqaCl7FlYcLN1sRYz2AdsxpWuTjCVOiYLze2KiNSdlOwfX9vMehV9OoLOm7cUMbpd
	 xDB7poWXqifUNlTRDZ+Wg0TFhW2JNiPRyOvvQIJz5A1q7ndFGlniUzwMPW0PwNXaTwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793687900;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Af907kGMXLFsFxk49Dhwa32CRpesJy8p/4dLo7RJWpI=;
	b=0g0fWHPUxhFhWMI9A1MXu9xg3ROGbpaq9rKkmR16jQh2+s+TFUwAYgPLhmXwU9S6XgZE
	 NShAv1GQfllE2tRSQBlVKhwPqbmjgrHGIF7mPtg9LlbnEQRxizjARkcGFAPnQsouCggoH
	 3MD72C5TjTSkzi6wKVT4akj5C3iWvUpLB+yUXrmYcYShExXIQ6fuhiuIELg6RExY7hMc6
	 9TG3tjdUwMAg3eVLfeCc4EasU3JVm3lQYHo+Jz3t1KkVBSkSUaDBQjymXDdv8/fjeltl6
	 dMi1Ya9rhE21dZoSws+INCRuBsnuM9p6nijqZesns/jGhL2sGu6XvljwiTkyuyFbZsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AB6606A324;
	Tue,  3 Nov 2026 06:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93AB6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2372d6ccd75111f19a56ed5b684f684d-20261103
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:de7df89a-d679-49cb-9804-d3fac707eade,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:fe711bcb5612b75cf5d7ed2560b72067,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50|99,EDM:
	5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2372d6ccd75111f19a56ed5b684f684d-20261103
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1924700789; Tue, 03 Nov 2026 14:38:11 +0800
From: Minhong He <heminhong@kylinos.cn>
To: andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Minhong He <heminhong@kylinos.cn>
Subject: [PATCH net-next 0/3] seg6_local: add USP and USD flavors support (RFC 8986)
Date: Tue,  3 Nov 2026 14:38:03 +0800
Message-Id: <20261103063806.132152-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC 8986 defines the PSP, USP and USD flavors for the SRv6 End
behaviors. Currently, the Linux SRv6 implementation (seg6_local)
only supports the PSP flavor (combined with the NEXT-C-SID
flavor).

This patch series adds support for the USP (Ultimate Segment Pop
of the SRH) flavor to the End, End.X and End.T behaviors, and for
the USD (Ultimate Segment Decapsulation) flavor to the SRv6 End
behaviors that perform the decapsulation of the packet (i.e.,
End.DX4, End.DX6, End.DT4, End.DT6, End.DT46).

Patch overview:

- Patch 1 implements the USP flavor for the End behavior by
  extending the RFC 8986 flavor action table with the entries
  required to process the combinations of packet info and the USP
  flavor (either alone or combined with the PSP flavor);

- Patch 2 adds the USD flavor support to the decap behaviors.
  Since these behaviors already remove the outer IPv6 header (and,
  as a consequence, the SRH too) as part of the decapsulation
  process, the USD flavor is only supported at the control plane
  level, to ease the interoperability with control planes (e.g.,
  IS-IS, BGP-LS) which can advertise SIDs with the USD flavor;

- Patch 3 extends the USP flavor support to the End.X and End.T
  behaviors, which can now take advantage of the flavor action
  table mechanism introduced in patch 1.

The series has been applied and tested on top of linux-next
(next-20261102).

Minhong He (3):
  seg6_local: implement USP flavor for the End behavior
  seg6_local: support USD flavor for decap behaviors
  seg6_local: add USP flavor support to End.X and End.T

 net/ipv6/seg6_local.c | 163 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 143 insertions(+), 20 deletions(-)

-- 
2.25.1

