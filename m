Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E623D0BE5
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791563269; cv=none; b=Wu4PwoRUMItzR02GZspcE41k1WrC0GKmqTPCpOu1KmSrwEk+xwOI1J+b//KMzKWBwr74zlHJKAfCRdWq7/O4RYTbQhmbJAactVdo/m6xvQKBLZLPUJclBMkvbEVhI2ROImTNHiOH4tu5I6jfbsA6juvJ8poLhZ5r651H/Tb80NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791563269; c=relaxed/simple;
	bh=GKuZVRqWtm+ag+MQ5GK5bzcEuGQJpFghJjgwjd6B32o=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=q8nQa5YLTrb3/s9x9rs7+uVSw/Wu1rHd9+EhSLnsO/lGtmfEXp5QbuaIs8fXWxWkb4cY+9slOBhTk68kq4k/mRvzs3SHk/GCc5HLxR7UPeY1FU06f9WbiG05qq5nRzhuDmrvfxAnpT3XM3DCD46kyRhMlnFRmwPvn+BTWayyf8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMuw2FPb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMuw2FPb"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e49fbf92aaso28256435ad.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791563268; x=1792168068; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZpE/NYqZeHO4dzGVhgtndlOxsshgd/TUZ6Pu7sEuBk4=;
        b=AMuw2FPb7GdjwGkCSMQTUXqcw9lP/hdEiGODO1kHoQBEeNA1yOzNQXNv4pjAMzkTY8
         WNiM5kk9PaKyHOsrLXQrak8M9Uww05gGz5vrRWX09wWZ29GklRtAUSsE0CpY+KJIRusG
         pLkYyR0FQdk8uE7HNnV2lATSMDJA6I+u4Sau9FdmsKJbFrxSkmXzaCOvf8PqyxhiicG1
         qnif13dtxudMfb+0YIj6HVoW1g6g+i33JxsniToEnXshiZY+W1rBk7Gk9HIco440Phyn
         kkHarkneULl7a+8iJm2XJSLzxQ3VlMlrMS7HJcuEEC/ozL87dEy1ZLv24gs4DJB4qr7Q
         pYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791563268; x=1792168068;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZpE/NYqZeHO4dzGVhgtndlOxsshgd/TUZ6Pu7sEuBk4=;
        b=uVRKWwWByHlKF09xOZpkWeTJVnCPxuy2LNX7VwlaaPcp4Jm/ChDZNoZ7LxwTeYISJN
         ZuItN0EaQ7+ONUTu31m3QOH2v/u4W0i/jDCp59Xb8bqASvKgt9OCwUh+ifTCXv9xBP4x
         0LwhyNFVHitgCEouCyV0q+9ELr137oFSaF5iHndZMYCNsFvtiYAkmb56Jf7XRGbacnVX
         dMyLI7vFKxu83PHkL0y1NXWauUCc9YJ7DcJTKv1KcXOy/9rBHeO6Lg0M4ytzdyaY5TOl
         glWyaX0q/brqKMj2wzI+mULrVz4SnuoGyWXYVX2M699guGk49pKPF6cdai+qvjsjsY3I
         RY/A==
X-Gm-Message-State: AFq9FYL7HkG0gpMWGNBGwsPoJkEEZleNWF1TSMTISYZA6K6Z7Hsnp1mO
	lVjFLa0TzHbN5QyUTBN7FC6A1tdeXJGEJOILhc3c2pI4pJ5SOXsMxE7a
X-Gm-Gg: AYBFou2ZdTEWI2XIuT/fZVohc18NYofmanOtMJqP7djnsLDwuW8SaEtVh62wq0iI+jE
	f+Gs8BigzsOO7RJrZw0WT5tCaJ8vjQTv/WaI/EczC9EoZGM7/8aBrOV2T9tE+cMSS8I3mcIzZAD
	38+pdXsq0AbJPnOn86Y9EYUqGNCEmxjHCGUoutaDGXRTMR4m13xmavnD1x7qDzfvP9OzK6skUxS
	3PyI5Mkd3P3Nq8++ORhWxTKJbemecO66F/AYwpB+Kth86WqvRTcnwM1/Iflp1M+Lm2he0d2Vco8
	sPF8u/4RSR7a56FGE2q4G9/Uf66lTOwHjFtRGrHy6fqpSKrCu0wucpXeXqyE6vlBMA3pqEXFIMb
	4dIBZ1QoBL9McRTZcXqJeqTxfLtiuIQWWgteXs/kklkH9d95Yrgit1jlpVmK4oLRzIhYH35vMni
	yEURW7rFenP4+WcpmjOb4QvxBt3A7xtKFB/dvKvlbgZcv3ivs42OwtZ6IUrlXWJvP64ZHfFPlRe
	psedH/IZa7VUf8Ih/62EJN2fcXT6zr8dHmN
X-Received: by 2002:a17:902:f544:b0:2d9:520c:38e7 with SMTP id d9443c01a7336-2e8427f11aamr22508725ad.1.1791563267626;
        Fri, 09 Oct 2026 09:27:47 -0700 (PDT)
Received: from smtpclient.apple (v133-18-180-162.vir.kagoya.net. [133.18.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422e4eb2sm13099855ad.74.2026.10.09.09.27.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2026 09:27:46 -0700 (PDT)
From: Echoo Wall <echoowall@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: [REGRESSION] 6.12.111: "net: advertise TCP MSS from the configured
 MTU, not the learned PMTU" breaks TCP through relays when the peer's network
 drops ICMP
Message-Id: <4F0FAEB6-A13B-47F3-BFF1-C706686C6F64@gmail.com>
Date: Sat, 10 Oct 2026 00:27:29 +0800
Cc: netdev@vger.kernel.org,
 regressions@lists.linux.dev,
 stable@vger.kernel.org
To: Jiayuan Chen <jiayuan.chen@linux.dev>,
 Eric Dumazet <edumazet@google.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)

Hi,

After a routine stable update from 6.12.107 to 6.12.111 (Debian =
trixie-security,
6.12.111-1), TCP connections to our servers started timing out for a =
subset of
clients. Booting back to 6.12.107 / 6.12.101 fixed it immediately. I =
believe the
cause is:

  2640e64195948a601430d230c9864f5426574cde
  net: advertise TCP MSS from the configured MTU, not the learned PMTU
  (in stable 6.12.111 and 6.18.51)

#regzbot introduced: 2640e64195948a601430d230c9864f5426574cde

Topology
--------

  client ---(internet)---> relay (Linux, nftables DNAT + masquerade) =
---> server
                                                               ^
                                                 path MTU 1456 on this =
hop

- Servers have a 1500-byte interface MTU, but the path between the relay =
and the
  server has a PMTU of 1456 (encapsulation upstream). The server learns =
this
  correctly: `ip route get <relay>` shows `cache mtu 1456`.
- Clients reach the server only through the relay (port-based DNAT, SNAT =
to the
  relay address).
- Some client networks (typical corporate firewalls) drop ICMP
  "fragmentation needed".

Behaviour
---------

Before (<=3D 6.12.110): the server's SYN-ACK advertised MSS 1416, =
derived from the
learned PMTU. Clients never sent segments that were too large. =
Everything worked,
including from networks that filter ICMP.

After (6.12.111): the SYN-ACK advertises MSS 1460 from the configured =
MTU. The
client sends 1500-byte packets. They are dropped at the 1456 hop, and =
the ICMP
error never reaches the client because its network filters it. The =
handshake
completes, then the connection stalls: a classic PMTU black hole.

Direct connections to the same servers, without the relay hop, keep =
working, and
so do servers still on <=3D 6.12.110 behind the same relays. That made =
the problem
very hard to attribute: it only appears from certain client networks, =
only on
relayed paths, and only after a kernel update that nothing points to.

What I verified
---------------

- Reproducible per host by switching only the kernel. Rebooting without =
changing
  the kernel does not help. Same sysctls on both kernels (309 TCP =
parameters
  compared), same userspace.
- On 6.12.107 the server has `cache mtu 1456` towards the relay, so the
  SYN-ACK MSS is derived from it (1416). With this commit the advertised
  MSS comes from the 1500-byte device MTU (1460) instead. That matches =
the
  symptom exactly, but I have not yet captured a 6.12.111 SYN-ACK on the
  affected path.
- As a workaround we now clamp MSS on the relay
  (`tcp flags syn tcp option maxseg size > 1416 tcp option maxseg size =
set 1416`
  in the forward chain). I have not yet re-tested 6.12.111 behind it.

Why I think this matters
------------------------

The commit message argues that on symmetric paths nothing is lost =
because "the
peer usually already knows the real path MTU". That assumption does not =
hold when:

  1. the peer sits behind a firewall that drops ICMP =
fragmentation-needed, which
     is common in enterprise networks; and/or
  2. the narrow hop is only on the server side (relay, tunnel or overlay =
egress),
     so the peer has no way to learn it other than via ICMP.

In both cases the receiver-side PMTU knowledge was the only thing that =
kept the
connection working. The old behaviour was effectively a built-in =
safeguard for
these black holes, and it has been in place for a very long time.

This is now shipping as a security update in LTS/stable kernels and
distributions. It silently breaks previously working deployments, and =
only for
some users, so most operators will not connect the symptom to the =
kernel. The
6.6 / 6.1 / 5.15 backports appear to be still pending, so there may =
still be
time to reconsider before it spreads further.

Possible ways forward (just suggestions):

  - revert from stable and keep it in mainline until there is a safer =
variant;
  - make it opt-in (sysctl or per-route flag) for the asymmetric / DSR =
case it
    targets;
  - or only ignore the learned PMTU when there is evidence of asymmetry, =
instead
    of unconditionally.

I am happy to test patches on the affected setup.

Thanks.
Esko Mobius

