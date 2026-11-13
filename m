Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794529313;
	b=iF29q4h8MVsDuISaFelUg9wsdvgTV3gYC4aGisKRcJMFynDhlDs9USzKGeGLP5o+5K5u
	 7YFuIGQXUNUCAf6KMTl5KpVDo+AIVRVkjhpnRs1596tMKV5sVb8aRxISXD6ia8KoDagvt
	 3ApvyNys5SMTL0/csjLzTOey2Iff6W3Q5w8Qjzi5ERS+o99jaOua/EOWqoYrpi3IEOyo7
	 +aZpmbMsZTknAuPOzFUR68tick629N0ZCIxg7g3s6qJFXHL3AgAwqxEDvv6xsU0m5BzTc
	 kdQZ4HmL3s4RvUyj3T+g3MBikVEAFEioqmyi9l4t5oAcQn3u5NVzMm3j6llxRIpibxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794529313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=IqWolmdquZv/c7/wxv5ORa4DRcStfB1TbKVp8alsTrM=;
	b=oCj7LMmcS//Y3uN0aA+w1ED1Q9Y6yFAB50NR+iacUvtrYRuXt7jz08uWW+o25LAMh/v+
	 vnwh22tSFBcoBRv18gJ0xjXyMAq2aw+sbttNhxhIJzli2T8GGwyIVfFAQgIJ0Tes45ZSz
	 lLKsVSFg4V0roWngleBf5k2L3J6INHCR2/VGRczjx7urpSUlQ735DlcqnZYrDIWfcxyZ1
	 WhtFRZ5c7MBYl9APAp0vafSbN3LROEucQEDG5kCLAxnsjo3kly1oa0psLa0JwtTOJ/7d6
	 Q6nUG1sVRbG/2KqFRw06QVolkWtx0aZTw1q80F2hTHuUUN+MHm98IF8dxcy/HlH2PRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=YxA35hnP;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF6D606A31C
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AF6D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=YxA35hnP
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91ec396c93dso8514856d6.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794529312; x=1795134112; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IqWolmdquZv/c7/wxv5ORa4DRcStfB1TbKVp8alsTrM=;
        b=YxA35hnPGj6u5j1QtmBRvnebUl2hflimmZcNsN+JZMr1Hqr6EP51+zRJlwJevssNuj
         qib1DpmuWvVpz5ge9/90M3fCepe/Joql0TF3tuoRxw0YvdS07EoR3Tt063LxkwU4L4Ch
         0vOKC2x7Xrka1wEJ7ffe/u2wKTQdGkR2yMidRR8l0mmQhH9Mf618uficzz9ebC44oqqf
         NoG0MNkG7Ll0h8UA6mCg75sEy8rm/WF/Lr9GKPfqs5W52MA9TSUITGOz01Cq7cv524Fs
         X9UaUBTdcQabH7RinazydJf4l85t9p8LTdaOKKhl3bc/xcsVhI09sAwkdmHyfhJiQQCE
         jztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794529312; x=1795134112;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IqWolmdquZv/c7/wxv5ORa4DRcStfB1TbKVp8alsTrM=;
        b=G8nF/D9oUJiIUneSGnIWuQXWYYoAl+vSBpTjZBePEFblLiDarhIc0DUl8AM3DC/r1D
         7bYSoIoFGFeCvqbUZmaD5w4t99F1MaBhmsGO20+yjnEKOYAIRWqKfB7LY8kAjltzCYNW
         acfCnFi/X+zQse8bnrwcbVLU8PfOZQ/PbF6qvyQ81+GI/YMfuje2j9VCs24c1BAJPxVO
         GKAOu/aav1p8gT+guGwCm8MP32h/Q4UHSM3bofJ9PIDgMPB9HOFmBAbRK71iRvhefnqG
         e5uNZ+Bvn2btjvbk6x3YYubnpC3sc69B8QRrgf5atz7y7fpI5zoBRmV+SYGAdtwe8a/+
         6CzA==
X-Forwarded-Encrypted: i=1; AL+hErG28qKuHM/QxVvk2a/WKBghkjyUgZawrKCUo1Zyd7JF6OJh86Jd9/tVtXwsFpQ1uckHCx6WJg8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BDeoU79cMYRj6N3C/DXIHPVUqKTcQJ0M7A/HO9oy/aSQDJPXo
	9iatc1Lk/eZo7+KEZ80Fnsbcf5WJcgi2TePmo4I1PL/4vWVbrPiwpVCLqPtD5Q0QtKc=
X-Gm-Gg: AYBFou0pAP2GUxQtxXl0LpibvIL4sTSb7TleaH6VLBmFTo91K7QEb07IvOFZM9qoNoR
	s6bSsqmnbGPd1UHRIXMeouRSL2u6IadvWWBkRxAcFdmcWGJJyMjlLbOHzMdTUcSUYh23sIMusM0
	PGGJC11KO2Mr9UEpDuW9Yabrmyz+HoLuMtnTTUmQWaVrWFru7iz95sRULhOnY/RaE9Kx51Q643V
	DpcUI0nitXAmXSMNuA4tZEWSX+v3Dl5P4MyOo/TffJIpWrFLLd2bfrr5DKp69eviYrr9aLsz9An
	n4LTJ5NeA9yVO5sZ/bhiLLBAsAW8v3FqNgBCiEWbNqBcw6/nS6CuRvaWjPtbfN0qNM+swjK0gIJ
	Ejzr7aIwBDK/DiMYX9fvYY6ijxcINDb4+qIQIADcmWomC80ZRuFVwzyIPERyhPeQfZCPojRRbJJ
	t2eXtiDWQ4YURcY/2fba2spU7xy2GEfpJ0k7ZRILPaomdeNeti2lqre8Q9p/ATPhe57ZoqKs3lj
	7jc/BPuJOd5MG935hF+yWyQOu+sPzte8y7lvHtOY35Qio5XrjjzC9KQhu/ixD4fsL3UeV7Hd/rH
	OqLAbpFQW6UARfcqFVxPaCb85tsVyia39RTs+V2S/iOQWZV/3uwk9hnci1rIUJd/Gxk=
X-Received: by 2002:a05:6214:31a0:b0:91e:7ede:63fc with SMTP id 6a1803df08f44-91f24240a04mr15502166d6.51.1794529312118;
        Thu, 12 Nov 2026 16:21:52 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23da64c1sm7724346d6.37.2026.11.12.16.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:21:49 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH net-next 0/4] net: skbuff: skb_segment() fixes for
 frag_lists without SG
Date: Fri, 13 Nov 2026 00:21:27 +0000
Message-Id: <20261113-b4-skb-segment-clone-fixes-v1-0-f777fb06f3e7@toxicpanda.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAhY9moC/3WNyw6CMBBFf4XM2omUEAn+inHRlivUx2A61ZAQ/
 t1W1y7Pfa6kiAFKx2qliHfQMEsGs6vIT1ZGcBgyU1M3B2NMw65lvTlWjA9IYn+fBXwJC5S7fhh
 8B1+3fUt54BnxNXL/RILEgiXR+efoy13hU9kuWWcV7KIVPxWp4P7PD23bB57cyeC3AAAA
X-Change-ID: 20261112-b4-skb-segment-clone-fixes-79ddc7ec0494
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Fernando Fernandez Mancera <fmancera@suse.de>, 
 Mina Almasry <almasrymina@google.com>, 
 David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1794529294; l=2621;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=N6oTm8dnDgMGeYFLkJx69v7Lwsz0iS+149VylRWUeJU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCC3264atCJl5NHn5ppC3NU8XyGqvxxbstlLgyi/8FI0I8S/EM/OwR6v24A2lczAKTkd+W8VBRV
 TH00CZPR2AwI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Hello,

Sashiko's review of "net: skbuff: don't run off frag_list in
skb_segment()"[1] found two problems in the branch of skb_segment() that
clones a frag_list member.  Both only show without SG.  That series was
applied before I got to them, so these go on top.

Patch 1 is about a member that has a frag_list of its own.  The clone
loses the nested data and the next member goes out in its place.  My
patch made this worse: for some layouts it turned a NULL pointer
dereference into wrong data.  Nothing in the tree is known to build such
an skb.

Patch 2 is older and doesn't need a broken skb.  Without SG the copy
doesn't move the frag_list walk along, so a member that has already been
copied from can still be cloned.

Patch 3 makes the GSO KUnit test compare the payload of the segments.
It only looked at their lengths, which is how I missed the first problem.
Patch 4 adds the layouts that went wrong.

GSO_BY_FRAGS is left exactly as it is.  It needs a fix of its own, which
I'll send separately.

The bug that patch 2 fixes is in released kernels.  Both fixes change
the condition as that series left it, which is only in net-next, so I've
based all of this on net-next.

I tested this with the net_core KUnit tests at each patch, with each
check taken out in turn to see a case fail, and with a throwaway KUnit
case that segments 100000 random layouts and compares the payload.
Without SG, out of 10000 layouts each:

                      wrong payload   -EINVAL   right
  nested, net-next               61        78    9861
  nested, patch 1                 0         0   10000
  valid, net-next                79        39    9882
  valid, patch 2                  0         0   10000

The results with SG, and with GSO_BY_FRAGS with and without SG, are the
same before and after each patch.  I also ran SCTP over veth with
tx-sctp-segmentation off, and the tests from the earlier series under
KASAN.  Thanks,

Josef

[1] https://lore.kernel.org/all/20261104-b4-skbuff-bug-on-followups-v4-11-b7ffeb364f5d@toxicpanda.com/

---
Josef Bacik (4):
      net: skbuff: don't clone a nested frag_list member
      net: skbuff: don't clone a stale frag_list member
      net: compare the payload in the GSO KUnit test
      net: test more frag_list layouts without SG

 net/core/net_test.c | 199 +++++++++++++++++++++++++++++++++++++++++++++++-----
 net/core/skbuff.c   |  12 +++-
 2 files changed, 190 insertions(+), 21 deletions(-)
---
base-commit: 676f3aace662fbbc180b3898b190a372fa2a516b
change-id: 20261112-b4-skb-segment-clone-fixes-79ddc7ec0494

