Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0823330675
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 05:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787896467; cv=pass; b=Qe9Z9KrwrDA8ChafNrSSmnFsk5KCIyoW9peF++Qj5nWzkUh+2AJuyF2zfsbsnuxnZ3fGqSkllOwI7jLZFnLlz2e4kO+P0A8PnxAtsv0IVbkdAS5ef2ef0pOW8JFrvtfTIUj3QE6LUiBuUEqLq6piqO9VjuQAz3J7obFgObqNLvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787896467; c=relaxed/simple;
	bh=/0Cdw4au/NWAOW1gKcqBCl9EGWFO+qvu4+6nyz58oT4=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=UDl3e3YvkyjaetkWX/WU8fMreliQnc+fAcIDNxj2Yz/WxDikdSeAyuGaQcHSM+6w6uh9TvatyfnNxKFiyLhlodGojq30O6qPkGoPRn0x7GulByqegaWC1fEEJ6BiYlUK5Ey/u2LnMxLl25y/B20IiDB4835CNW9K64lhv0Ayrn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=BTauciyj; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="BTauciyj"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d6fe26ef1cso4727495ad.2
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 22:54:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787896465; cv=none;
        d=google.com; s=arc-20260327;
        b=btyj/LICt2WQ7CaTzZvTXlVo+4ombNc4N7cAKAexiJS4llKuFZBiMK2JYPbqmzut1p
         vHek3jUD9qLAQJVBj2iY/VUztMpn07e+puAQRMSMQ0ZqavUwyTcPIxxoWS62arYt0tGr
         xagoZ599oNE0tJLlkkjYzcLfYJavBVBL4MbIu+wXwF/nd38QX9e+Ki3c+Ty1KYV2MX7A
         xCNcbeNiEfifTi0JVEm1mnxxQEZJQyfXOGb3AMO3Tb4YXNoc3Iw6S+IYvAvBjtFQ4jdJ
         3ZB8LsFwWlpaTbQWEmNFd9BGkmTeYnzCqrqujK9UU3pxSrciRuDWHR5MXQqLh97wLbbS
         asYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=UZoqGay6KxEWFh3xndMaQNDY5TP9TwG9uYWqZuch+Fw=;
        fh=oPkDzV3qj1AmewSUkz6R9hfxfhfol7lk26/91uvRnnU=;
        b=KVZGE04kT1D1HWjXJpDcrUE8wkbDyRwNiWoNVIbNQysR2DNYofmju5r/9/NWdoCGrd
         DitiHx88RvZLrb6QjN54hxvFg9y77HNU/eK6HnWmcCrI4F/VZz3KKQxkvApZLZTLIueF
         PFsJbUn0yITn6L7dqqxkx6MWxhw+UYkGrBlwfch0B2/H86owsKvwk6vR4GJk/SJUQ3Sg
         qD1xUOKyk6+gzxeQYeJEf1wB4ekAZKK7cAXKM3yD6Ch40eaCx6PhZF5bPU7iVaa5+Pw8
         wIiq8QZs+M2r3GxO60fc1qzi8t8IQtAyrdc8Awa5vQGC0bqB4s0+uZnSoWxNTtIys4wJ
         2IZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787896465; x=1788501265; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UZoqGay6KxEWFh3xndMaQNDY5TP9TwG9uYWqZuch+Fw=;
        b=BTauciyjJrJ/o/uyPradylDDgOcI2GMjrNIwj5HMMvyVuNnes2yM6Pnm4HF3sygsxP
         UhIYAec8mlm5AQT+K+TEk9uygYsqKkICobH4DmDNpdRk0WMPXk9OpXO9Q+Rj9FJk6lF+
         862SL3CI4JowCCDcsMYBXyAeBr38tEM0WQJP7BP/d+Hvq8Z3y+VeNx3lZg9pRCYTk+PH
         75DK87x2IiA1afTV1vrqFrfBLElbq5tg+Vb5tyMuVhMx8GjZ2hR8x3E+2XWIfWYLY5gJ
         3YXpTYDq/wUdMv0C+k40U2mlrdK3dkFynrlFIlOHjycxWqjBeJl+Riw+IPiLunBqvXX4
         kMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787896465; x=1788501265;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UZoqGay6KxEWFh3xndMaQNDY5TP9TwG9uYWqZuch+Fw=;
        b=Z0Fmqs+hErVh/S2z1BJWFxoXycOdxj4aYTg7h5wiip1DqMfQPfjRLwEgN/T/+2oHOa
         JzG06cY60yj5YxuTrleSmwXeGratQU3NWEceSQR7uLM2Zz8m5Mbe0DAm0K/Dqbq4FYjj
         aACN+UQrsDS3r7f2O7iM+03GOvlwGGZ4y+SzjsRP9i0EWGrSQhqWrYEjyNQJa9Imu0b8
         FrP/zzqkVdfvKbd3LJteD9JgyOC9Gov72wKbcS50SNRrgm/0sM0tAvy0rQSkRz5ubAhN
         BIADI3wN8BSvBqtyXNf1yiGrnrDWgdAb1ZDDGR6VAz15HWzHUlHMTFhgqCs4HqF1p8tK
         7+2w==
X-Forwarded-Encrypted: i=1; AHgh+Rp/jI/WeYao3kM5XtFRaYRUuazUPu5C3YlsjyO3+JPcz/Ll2AUXkH8kThD0zY/Wp83X3nfweow=@vger.kernel.org
X-Gm-Message-State: AFuF++lZv2jtMAP6D4z3irJreF19PInyHsmG8JZv2LAw18BlKxr0CB3W
	qt8uiSkDkTwWDXaMTJLsYJJn45OyBsMSAZ2QksFN9QW7b4wpfE9GzyCFXzOSbaCDglo5iXUAxrO
	lMSGsSbUX7LuaxWK2ya9IA1iYN6D1/szHPWfFwLQn
X-Gm-Gg: AR+sD123S/+ob1FKS42dr/CkMR8X5vJ+DZqsU9hKL09pwji6P+hn4S8Ae4ZcrZLZzmv
	LHLdARIqTgFw8biNz0n1oFTIYj7K5sU+e9ZKINFdqVGh1lXB1ot58D6b3WTIEfB9i+ufbiDHyno
	Nv+12B/uogrdPQhTfI933GjzEVMmU5fp8siBTSx/COOY9Ml7P1uXNpVtsH9iLOvoQsMP8YQAmRF
	L7Lf8INQIPJDEDuSvey68uNgdQbLvhtkubgYGZpYRiaJmnjeoKbzwzP+oOFkumSKm579bJGwtTA
	S5BpOpAPH6uxOFBWmjxDZxUfEpCK+2W/Qa6PZoxfPULeSOJB9GGMEpMY9//xu5Mo2hBWVOvMzSB
	40zl384zbplpKLngjaBBrvH+lQVtSLmgZ
X-Received: by 2002:a17:903:3884:b0:2d6:3c22:993a with SMTP id
 d9443c01a7336-2d74dbe96fdmr93208675ad.3.1787896463846; Thu, 27 Aug 2026
 22:54:23 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 05:54:23 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 05:54:23 +0000
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Aug 2026 05:54:23 +0000
X-Gm-Features: AcwNN1WqSzPeWvvBW_uhjPicafIKj_L5muzKaoHy2ATtmGpknySjkignXwdG-og
Message-ID: <CA+0ovCgjFA-dX-jdTT22W0SM6UFiDb4L8GFn=Sq7Z=cAE_Xsog@mail.gmail.com>
Subject: [BUG] WARNING: ODEBUG bug in chan_close_cb
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: falemi@asu.edu, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/200-warning-odebug-bug-in-chan-close-cb/

  ODEBUG: init active (active state 0) object: ffff888114db0d58 object
type: work_struct hint: delete_netdev+0x0/0x40
net/bluetooth/6lowpan.c:252
  WARNING: lib/debugobjects.c:632 at __debug_object_init+0x2a8/0x4a0
lib/debugobjects.c:790, CPU#1: kworker/u11:2/9426
  Workqueue: hci1 hci_rx_work
  Call Trace:
   chan_close_cb+0x3c9/0x6a0 net/bluetooth/6lowpan.c:819
   l2cap_disconnect_req+0x305/0x510 net/bluetooth/l2cap_core.c:4515
   l2cap_le_sig_cmd net/bluetooth/l2cap_core.c:5556 [inline]
   l2cap_le_sig_channel net/bluetooth/l2cap_core.c:5598 [inline]
   l2cap_recv_frame+0x8ab5/0x10400 net/bluetooth/l2cap_core.c:6964
   l2cap_recv_acldata+0x682/0x1330 net/bluetooth/l2cap_core.c:7688
   hci_acldata_packet net/bluetooth/hci_core.c:3855 [inline]
   hci_rx_work+0x4f9/0x1040 net/bluetooth/hci_core.c:4082

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
