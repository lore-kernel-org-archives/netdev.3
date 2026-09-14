Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0994441168C
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376092; cv=none; b=t4ntIENiYmwp+gxgNwm9toPPNKi1z832XMR8MKXFj2ANnF1VC9LkWX+i790sMvja14Ji7aKaZM4GG5wz0BwoSYe1c1RSmBkmT9b2LqyH+HuauJTXaZ4cpyJU7nw2amfR8Kbz2UHn2kXxdMG6UDvDvivej/Hwn3oexjnWMn8ki/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376092; c=relaxed/simple;
	bh=778ZCIpXdFliAd1OcIaDAMDH7/zEs1zA5ExgmhS9XOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrn0/G9Or5U4l/R7YzVl/H87RN1132sNO147SirR5T1osHfLZpzvC26rP8D0SCH6pQN02+ZCM8qOEQFllH1MP4vrQimjZ4QnX55Ph2zJ6vLSjfzKVTb9/Z51CCiKBaiikXudMjte2JaDEqYlrw8448KRiKvulIOTL1ZwsqdJ1vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVEipzBX; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVEipzBX"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f705536so429084466b.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 01:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789376085; x=1789980885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vB95dm/EBXlJjTwHZ0O3bYZWUKSZlgHTPeTJWPhfZmk=;
        b=eVEipzBXq9Ljcg243BQ0z9GScq2gbgs2TygPKKws1uVSbpzyKoCcgv8JQayQxDyKt2
         GYwBgik/Eb3DZj8K0ZGZspME/dQu+0RnuP0kVP11MsGRYA74ShecINnNjvMLRqJTokXh
         ei4k11lXjEg3rRcby6THUObZcXQBDx2qHweEqtppuhQABfBIFJAh7FT6oRByP9iwLAnp
         k78IyJSnMWqc7BzjdpROgwfYFDrZD9vj+lG1qNQ3ITlgU5Yo3/673Ue9QQUkFDZFb8FL
         qvBTlSOZA/E0bOV5wgCPeFu93/IyMp3Do4yohcGURP1oSLrzH6Xo++c4zjoI8sdhOAwk
         j1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789376085; x=1789980885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vB95dm/EBXlJjTwHZ0O3bYZWUKSZlgHTPeTJWPhfZmk=;
        b=jZxKQ/DXrpZl2OkpY+GS8KaZK8Ng1frPI95yM4hlj/0sKbEPCxn1DGw9asyy0V/NiF
         s5J2XDoHVNmX2cCOmwCmf71G1Tmolw9oowylDa1b0lPIJwQu9DBXSn9xmXZcvfeavIyw
         GOSt5t2qbsNJ9xgKod6oExCrMzGmIet6Ibuvr4nmbVQD2+PPn1ZATtZaDsxJRTCHabJu
         Am4q3TpMKXRfpvkqONE9vBduAlTRf+RAXgkrxKnqM2KxNLVUWG+QAhUfMX3piUvdOV0G
         bqJk/N5pplom6rm9HpamIfjaC0DFqsg5qMsQE+QIIv9g8cN32YeyKiQ+YJ+U3r70YVPY
         SA8g==
X-Forwarded-Encrypted: i=1; AKwUvBzYovPkMJX5tGHLhPGuskBQA/ZKPWqsuJzPcOEHPxW2DqJVBTivY3nwPjT+tY8x1W4GnYK+xWY=@vger.kernel.org
X-Gm-Message-State: AFuF++km1UY0PORKMGMnkBBJ6h5FVlXmktibnWYQxtmqZqj+iZTBWQzY
	aH3nfvRgSOPZtaUzm8uyp5pPUCPqYv0ZLKLq6W3hTLCgPH+FAc8kM8bc
X-Gm-Gg: AYBFou0DtZEM7LbkXBGbOuF5Wz+8oR93pNouDFl1dDpLO6OCuJJW7zShVrakUdDBJl9
	oV8HG4fItkIaliyOZmwrsRjKODlDtfWJly5rMM/87CT3OObNd49sa4qSK1B0QyOUOUblt9smrLc
	gRjUPqCAA0keMoclPAys0Fu76iV5ZXabTV4rbaIldwhMpU48POKFyffIqIOe7yV+UhUL6+tGtEy
	ghBlYiyZlfhM2Q3pT8b/RoegnCk5WZzbeT+/XmPEN5SEbyedtzx/igK1C4MLvYUWz5TLhYCXuIZ
	nwi3G7mLQtQQYEHubea7MaBnmbn3Tk5RvFGYyYFzre/23DeTpraACmogNg2socekW/qCKg+9RRh
	ueLAoK/z2b6Tkxiqe65ExiMVemM/EoC1ahsBAe7cYlB/IUzdfuzOom4bzu098hiVgOqK8yrqrL4
	QirFECnJG/xpSzuVnoLip3agbgaeJc3OQIQYfuvCVEwVYyK0I0hAzHPhmfohYa/4/UkWB+8Gdgr
	Xc9HafcHACEmQiyIL1nfnqInVVxNFxJJf+xmncTJfdK0CpJeTqx3L5yCw==
X-Received: by 2002:a17:907:94d0:b0:c16:5cf0:3aff with SMTP id a640c23a62f3a-c29b8650376mr101417766b.18.1789376084678;
        Mon, 14 Sep 2026 01:54:44 -0700 (PDT)
Received: from BERSOARE-M-K4D5.cisco.com ([2603:5004:20a0:100c:4701:1ac4:1c21:4a1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29ad3e033asm101378466b.47.2026.09.14.01.54.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 01:54:43 -0700 (PDT)
From: Bernardo Soares <bsoares.it@gmail.com>
X-Google-Original-From: Bernardo Soares <bersoare@isovalent.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	saeedm@nvidia.com,
	Vlad Buslov <vladbu@nvidia.com>,
	Bernardo Soares <bersoare@isovalent.com>
Subject: [PATCH net v2 0/3] net/mlx5: Bridge, fix remaining switchdev ownership gaps on merged eswitch
Date: Mon, 14 Sep 2026 09:54:27 +0100
Message-ID: <20260914085430.18694-1-bersoare@isovalent.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <dd3247a9-14d5-4866-a20e-b31d414ec1a1@nvidia.com>
References: <dd3247a9-14d5-4866-a20e-b31d414ec1a1@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2 of "net/mlx5: Bridge, don't fail switchdev events of sibling
eswitch ports" (5f324c5d1b12), addressing the two follow-up issues
raised in review plus one additional issue found while auditing the
same code for the same bug class:

 - Patch 1 is the original fix, unchanged.
 - Patch 2 addresses the reviewer's comment that
   mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get() picks the first
   structurally-eligible rep found while walking a LAG bond's lower
   devices, without verifying that rep is actually tracked by the
   calling instance's br_offloads. On a merged-eswitch HCA with a
   bond spanning reps of more than one eswitch instance, this could
   cause a bridge attribute change (ageing time, vlan filtering/
   protocol, mcast) to silently no-op on the correct instance.
 - Patch 3 addresses the reviewer's comment asking whether the peer
   unlink path also needed changes, plus a related idempotency gap
   found in follow-up: mlx5_esw_bridge_vport_peer_unlink() lacked the
   merged_eswitch capability guard that peer_link() already has, and
   mlx5_esw_bridge_vport_unlink() itself returned -EINVAL rather than
   treating an already-absent/untracked port as a no-op, which is
   reachable on a replayed or duplicate NETDEV_CHANGEUPPER unlink.

Tested Patch 1 on a ConnectX-7 NIC (MT2910) on my single NIC system.
Patches 2 and 3 require a multiple eswitch instance setup, so I wasn't
able to exercise their code paths.

Bernardo Soares (3):
  net/mlx5: Bridge, don't fail switchdev events of sibling eswitch ports
  net/mlx5: LAG, check if vport exists on br_offloads
  net/mlx5: Bridge, don't fail unlink of untracked/unsupported peer
    ports

 .../mellanox/mlx5/core/en/rep/bridge.c        | 45 +++++++++++++++----
 .../ethernet/mellanox/mlx5/core/esw/bridge.c  | 15 +++++--
 .../ethernet/mellanox/mlx5/core/esw/bridge.h  |  2 +
 3 files changed, 49 insertions(+), 13 deletions(-)

-- 
2.50.1

