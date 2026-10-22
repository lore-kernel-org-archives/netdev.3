Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660528;
	b=fe42ps9ZmaWXx+WZiCoQuTLV6CLWO1lFF7+OX1yK9SFkIKBQJkpsv0JFIa+jnHxfsDSj
	 RsGpN4Qpinpw9TUKDIKAfH1f8Yyf+Fxt2N5rKtPc1uNVZNSZKidd+PWXxFPjcWDSlzspZ
	 yHUTzbIY0FRfrqPfURRs6JcKJZKqFcqivtEh3IlZHEfNTD/ZUcwO3oT59zS08XG9mqpAf
	 OYjpyEaritQnjTZfwPDkku5kP9S4/H25+I1YLRfPQjEaXi6mAsTECjgV/gRlCX95zS52w
	 x+215T1BccaPwWRFW8SCt3wIVFd1zVigcu7UwSqE1bVp6NrEdCP9AYCJjtdxsRoclIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gJVw9ABNp21KP8Dhio2Mev+A1bfhiVXJze+OMhpKRQE=;
	b=KhGsASeq8CR0giPeVjRhYpm/DJ90/gf5K7otUWUWITz5OgtwEy3nbTKQlSKmE0BHQ7Ah
	 9KOP8cOtkfoYEayI/qdmodIhYMjfokICmuFxV9vHYAcf5pLiHtytzQCBm/yCSeL7+eI7+
	 f0ICHzw//CVy1t6kYYjxmu4c0Jd0H3ACcuHa4gePLG7e4rUhOb3ps/FxLeYSQYzTnnsP8
	 4ilkwOIqbntah39O6fqQqU53qpv2LOx+yGIs3KwbfdRmOQ1vRFuarBnRVp4B1yWtjMbIC
	 UacsKVqcH8sY8CzgMcbF21x1hz2N3OCaxeNxz6SpJcBd07fRAXObfDpFYFuN/RQM0Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GAthkhYz;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6AE606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D6AE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GAthkhYz
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso2858943eec.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660527; x=1793265327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gJVw9ABNp21KP8Dhio2Mev+A1bfhiVXJze+OMhpKRQE=;
        b=GAthkhYzoQxc9tbyqj1+tAJY3lAEuewGDkaLDUG2rnLdTns7vFJiW5l7PU5D/pzi/Q
         FQCZBW71GckViC6xxI5XdGjEbKSozKi69B+iNjcoe5z5CL8QhCi69F/yiT3gfLR08jvJ
         01qzGjUadduJnMhmEHR1+NkRougwF7J2Vo3PMbqL89/2DEuhFwYP7XO7l0zPwtFgtFIE
         i2PU0PfuY/eg7OJqpGyeGXnbPN1yKo+Cjb6eykXxjXQiWxlm/4IkZkQDqxo9Cs2lsLZR
         wMW35dAVHHSF1bUFqqC7FTzA+hKcSirb+QB1diUfbCz/bojlwzbtHZKOmcKwmJcKoiXs
         41Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660527; x=1793265327;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gJVw9ABNp21KP8Dhio2Mev+A1bfhiVXJze+OMhpKRQE=;
        b=smFkPSkVAxw4om3J5EMCg/K4j4YN1qOEhFxRFEzmeWRlO1BGYhRjaJREzb09gWCBA4
         88lVLy3v7I18ydBi/c2zxxE6NXnWECTb7mVncVYESZKO9N/ENTJirrdg9p6Ti7uOgAGT
         I4VfIuGDrnCUcYbD56UwXkDkiHLFfg/1U6gyMvKlkAK9UMM6yUZzkrae02ERO5ncEf69
         nRr59RyTjfFzRzpzpmZ9fyqhKn40o/Tfi8Ney1dBfUf0DEFqiwHaDALSvMfwrPMOZN/1
         2dcg1jNEsTzjxZ8Mm4gfPx+gYga5gT/De+7MZ3l04S8QRKLqJF3MfVA7xLpSgSIfZUPQ
         UGow==
X-Forwarded-Encrypted: i=1; AKwUvBytnMkoq83OsP36czGqbD0y0xd2basQEsS2b2VoQCq3B5s3HT8CJBDBNSFZovjjb5oPnsbajlY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9zA377kWkZbWGFpqAWkfvgxTPSfbt2ttYMaXhxkk6XBPhElhA
	sfmqt//V0UBGa+C6B+KYetZzClGI0iTJoEQ9L7ksISx4XQrPsTtrv9to
X-Gm-Gg: AYBFou3dQjntmLNZhQTqQ3ztSCrlR7PcpLb1/XAA2zZHZZkR/wpUzxu/DRbacRU5E/c
	+Dr8l1WIvLnGpDL07J+JtumV+IHN/B8a3RQx4QX4/ihKnSvu2KBYK17/dimpdBOST5ZxnrXtsU0
	4ZV/TWFrLQNEAnY/MyYmRQ6SBL0lMqEGRnIuyiI2IH6MXkpT/gVheUtZ5izQG+sGB1GE3TrFuEz
	E5duRvjvp/Zu7hYmaBa4WhD909JSR++XErtPWCqRf4+NDQUsytSpBUBVGib2HTIqm3WlFrHcHMO
	m/R8rIMCYrCoRio2njVURr2sQSqmpdO2SB5Zw+NuDHVs2/rQtgCZ14GdcVGKTw7n1M0niEFOair
	06Qw0kA7Ymg5WgPmYgBXSkjFIUgl7GuJscDzQpWyoAIbPixtupupyZ5QDgnRkPQ25hxSM3e56lP
	Xvubv0n7RdFx7UsmoxaSPexcdvv5uU/WMgKc6HdKYSrJIW21owswvVrl7iW1SasMRow+Wj7Afya
	zbFo+Ow6lZzXYpXidYh5zgsX0HoV1aUgdpM/nxSF0XgeUHsrIMMZbsXjSaCjHp9aAo2eGmLNy8/
	vxIWpNcCeaZ832PxFJs=
X-Received: by 2002:a05:701b:4189:20b0:144:fa58:95d8 with SMTP id a92af1059eb24-190a599a3b9mr6064440c88.27.1792660527292;
        Thu, 22 Oct 2026 02:15:27 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a275026sm19853944c88.5.2026.10.22.02.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:15:26 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: bridge: MRP state is not propagated to MSTI zero
Date: Thu, 22 Oct 2026 02:15:20 -0700
Message-Id: <20261022091520.3651032-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

With MST enabled, the bridge data path uses MSTI-0 per-VLAN state.
br_set_state() normally synchronizes MSTI 0 through br_mst_set_state(),
but br_mrp_set_port_state() changes only p->state and sends a switchdev
notification.

The MRP-aware guard prevents other STP transitions from synchronizing
MSTI 0.  Direct bridge MST commands cannot address MSTI 0, and direct
VLAN-state changes are rejected while MST is enabled.  A ring port
marked BLOCKING by MRP therefore keeps its PVID/MSTI-0 state at
FORWARDING and continues to pass data.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1:

  net_bridge_port.state: BLOCKING
  port VLAN state:       forwarding

  MST disabled control:  egress=0 ingress=0
  MST enabled candidate: egress=1 ingress=1

The MRP instance add and PORT_STATE BLOCKED requests both returned
success.  The port was observably blocked in sysfs but still forwarded
real broadcast Ethernet frames.

The MRP port-state path needs to synchronize MSTI 0, for example by
calling br_mst_set_state(p, 0, port_state, NULL), in addition to
updating p->state.

This is distinct from candidate BR-039 (MST with VLAN filtering disabled)
and from BR-005 (deletion-time MRP forwarding).  I found no matching
upstream fix or CVE.

The test used a diagnostic switchdev endpoint only to acknowledge the
MRP object.  It did not change bridge port state, VLAN state or packet
forwarding.

The PoC, module source and full logs are available on request.

This was found with a multi-agent workflow; the
state/forwarding differential was reproduced in QEMU.

Thanks,
Cheng Yongkang
