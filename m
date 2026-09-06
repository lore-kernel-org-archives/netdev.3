Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5A2370D4D
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 08:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788682887; cv=none; b=WDffxnjETBfKw+sk/K21fhCi/jLSV5bvlqPeL0HCUfw706O5FQZa7S1XO31se59LArhzM7+keOmLD/lKWDRwzO4YV2qfQ/ETbyEnCzW9pZbY1rspcKMvRTPbvV7D/I6QY2mC/UHaJCM5hVxsgCkgC6ZbXkpoRq25xOovDezd7l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788682887; c=relaxed/simple;
	bh=uWZ2W3TIWOIxgvmEeGroNmD7EQCmDVXUTnCWCeAdOdI=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=bR1sRRu6ruI7aZK7LLC4FmYDO60IPc3QueqD/vcMZz2kSs6Dca8AS1oAjj5u6aM2tP2lkGdyJXYTLH5acK31D6KfiWwpfvSrOFqAMugaaFVE1fe16TfXuuomuQsaE4xaenKfDU9DoUI48i1EVQx9sNV8FQ2P9rwNQNuzJyOPUSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=b4JbnRqG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="b4JbnRqG"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a20319d030so3432335a12.2
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 01:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1788682883; x=1789287683; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ykqgg5xFEjRgNm2Nt/xqenv1NfNv6CR9lGS6Bj69weM=;
        b=b4JbnRqG0ITGek+quOZJ2oQZS/uIyF/kqND/qZ3z9HP/6pKpkQ4BGMqiVJRQ8S+lF5
         wvqO/U+hPdUasTlD/4ejZ3C8DreMLVvdlY2utmDjRXeheeYy5VuDA1ob3bFhQpQlhrnT
         x1T68JiJNM9CGPoXCBiYBbHnrL8oL/koHidtx0UAUdqcF9Vv5Pt89n1TfdCR4wV22YX0
         R7YG4FpImQ1IyRhn9VeUlSLTm5NLSq6b0Ys82SYsN0rJpwQVT1srlP1sZEECckl0YvVV
         eW60v5hCqQuhfSJy996v2ax35lMLzjJA7wix8rBiR3R2Bz9gInp1RmnD24ViG/oJeMzh
         GCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788682883; x=1789287683;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ykqgg5xFEjRgNm2Nt/xqenv1NfNv6CR9lGS6Bj69weM=;
        b=kDm2b61e7pyx+dPLr74EfJWstoFJZDUnpt2B1PPFxmQyx8u72+iPCM/klZLDMP/0yO
         e1OPyF8mTlakgdbCXn20BOlEF/u+4ucpIeIzVgYhXlWyRz+JxMG81Do0IvbcWT+1AXZ0
         UVstxu6kpzWpa6fcDnDcz/eA3EYBbS9Fhs7EcugIGl9NqiTCPAqePE9W/kYoMLyCeBVQ
         X1V0A84BIU7eY5Ez3VJ3LxHigCFspn1aORQtpwYzNv0amlhSQDgtim9B4VY3FH46YYWz
         bqbBUJ/8LaHktjPjPzIxHpKOkyREFLEsd5bNjDF2ZXmaKzDJk4vUweOBkr4mOlPBThjr
         McIg==
X-Gm-Message-State: AFuF++npycJXux5L0nDLo5ob65mgMP1agzWVuafOYmrsoJKkCr6ADFm6
	laGQApbJdq2FoFQSpwujadmoNRfMaLv2GeglbncZtMdfearCGiYLh1mrl+6hqH14iA1QCi0V7e3
	TXbX9YkGvVA==
X-Gm-Gg: AYBFou0MBmIo4+Cy/b06mq37rCitIJSyzmF1rZjrkaqNhpGXB0YJK2EGu0OJ3E3MGJT
	ndXueWr57poPRZBPaMF5emR1lFCpXKeNLCyR/HMoyPxagyjXCGOX2ZmNBEJvJK5WTZhaEAb4H9I
	kX7D64SGDdvJeRwgFH66bJP2LXIsl809JRz0zc7C1CvjWczul2x8nXzgomlHlOg4UkZ+J80jWYO
	QhLuujy1HSUCZKzqPR26vzno6MKoxhQKTE0bgvRGNjHF6/ZKHsaJ6jxr2I3tCBNZ3qe9Byv9rCC
	r02In2Fx892ZP+9aglaJdHNxIopNPJvhlYdF/7XaXhVkHV5IxC396qRyoMSiF1JTRoXRY2Yex4z
	jzhezAggfUPnFmpPetY2og5JvvALvCKKGVyOPfWj8xM5JXxJcobTx2/Lk4LTqvyK3mRgwaTNv4l
	uvTPazeJkkfCxVK78qqzdj9AZuLHoLHSqE0ze/6Y/badI1shegqLiELqnV/TDb4iHHxV5W64KED
	VhT1VSuuV5RpTkME7D4hUBzfZIVQUnNbeb8Zbo5og==
X-Received: by 2002:a05:6402:21cd:b0:6a3:87b7:b5a9 with SMTP id 4fb4d7f45d1cf-6a7e90aacd1mr5281640a12.12.1788682883313;
        Sun, 06 Sep 2026 01:21:23 -0700 (PDT)
Received: from smtpclient.apple (83.10.35.35.ipv4.supernova.orange.pl. [83.10.35.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68c3b6asm3091727a12.13.2026.09.06.01.21.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Sep 2026 01:21:22 -0700 (PDT)
From: Norbert Szetei <norbert@doyensec.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: [PATCH net] net: openvswitch: fix use-after-free of the flow table
 mask array
Message-Id: <DE115F9C-2545-423E-A702-986FC952FD62@doyensec.com>
Date: Sun, 6 Sep 2026 10:21:09 +0200
Cc: Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 dev@openvswitch.org,
 linux-kernel@vger.kernel.org
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.4)

tbl_mask_array_realloc() retires the old mask_array before it stops =
being
reachable:

	old =3D ovsl_dereference(tbl->mask_array);
	if (old) {
		...
		call_rcu(&old->rcu, mask_array_rcu_cb);
	}

	rcu_assign_pointer(tbl->mask_array, new);

call_rcu() only waits for read-side critical sections already in flight.
tbl->mask_array still points at old between the call_rcu() and the
rcu_assign_pointer(), so a reader entering ovs_flow_tbl_lookup_stats() =
in
that window picks up old in a fresh critical section that the pending
grace period does not cover.

tbl_mask_array_realloc() runs in process context under ovs_mutex, so the
window is preemptible and can outlast the grace period. Then
mask_array_rcu_cb() frees old before the swap runs:

  BUG: KASAN: slab-use-after-free in flow_lookup.constprop.0+0x2bf/0x2f0
  Read of size 8 at addr ffff888020b3e018 by task poc/741
   flow_lookup.constprop.0+0x2bf/0x2f0
   ovs_flow_tbl_lookup_stats+0x4a3/0x5c0
   ovs_dp_process_packet+0x19c/0x710
   ovs_vport_receive+0x243/0x390
   internal_dev_xmit+0x81/0x170
  Freed by task 728:
   kfree+0x16a/0x4e0
   rcu_core+0x853/0x1030

Publish the new array before retiring the old one. The kfree_rcu() that
call_rcu() replaced ran after the swap.

Fixes: eac87c413bf9 ("net: openvswitch: reorder masks array based on =
usage")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
---
Reproducer available if needed. The issue was confirmed on a KASAN
build, where the crash reproduces in about a minute on a 2 vCPU guest.

 net/openvswitch/flow_table.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
index 67d5b8c0fe79..1e0f9d193eb0 100644
--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -257,11 +257,13 @@ static int tbl_mask_array_realloc(struct =
flow_table *tbl, int size)
 			if (ovsl_dereference(old->masks[i]))
 				new->masks[new->count++] =3D =
old->masks[i];
 		}
-		call_rcu(&old->rcu, mask_array_rcu_cb);
 	}
=20
 	rcu_assign_pointer(tbl->mask_array, new);
=20
+	if (old)
+		call_rcu(&old->rcu, mask_array_rcu_cb);
+
 	return 0;
 }
=20
--=20
2.55.0

