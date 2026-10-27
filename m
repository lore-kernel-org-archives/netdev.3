Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793135843;
	b=rLc9zZH/pqOPNlHyEDY5mESR2CSPLTXVGZkipivXxci+842zWQaN78rePLCV4eVROQPc
	 heYFPyhqcuIlXikwXwJNe4e1ox0GnfCB65BUmK3OlAKp1yhC50ckjUq9jdXH1XNIxtCgh
	 8/jqBEvUSBBXk3m4R7kpSFv8Rgq92qaYO2e+WHvtO70wE3kbvDe5ja0ykVMLjLL+zj8ST
	 etVnJK5sgGH1bUqVwZV+pGFa6G9SDwpBqYSj1D+Jp20sY9j1DbqczFlhy4X9pABfe38Ke
	 UybChA8AvvtqVJjJZ07nSbvKDZwWENdv2vt++yMtA+iT2mgVBswpf63vsYJs0xOUpHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Zj22U27fdgZfpXBChZKoCg3JgtYeQCimM1Wx3cOZywk=;
	b=MV8Dp9qIF0JcyxEindELuBZbAwXkvPiHOIMutMIqE7/SxeQlGK0+0iYU1GWJIe6DyOQV
	 3s5rtyaRFPDpcoJ8H6jmYv/hLn2R2exuPxZDK+48zaGiarb3lXWSQOjLjBehW6DK2SHDR
	 OtDE8orbqAWJXINcPP9c+U4dAGXD2kMGB/zl7NY+9HkPe0isCcvbVG9Ct9DVAHTUB9YtP
	 NF1QmUjsF5vC1xOA+xOy7hDNHQIdtYmrcMNQlVgjhsXfVJIkqBM7sm7fkEBnkbA7wwIWs
	 Rr4R3BEI0klsyUl9t7ZFq06diaTxFqomgqRDnm+Od+CXvf9EV6G+EboeoP26pHSL+Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lZeiPTlH;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29679606A321
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 21:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29679606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lZeiPTlH
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5ebf39def3aso131338e0c.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 14:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793135842; x=1793740642; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zj22U27fdgZfpXBChZKoCg3JgtYeQCimM1Wx3cOZywk=;
        b=lZeiPTlHAEZ5czFIkYojaFeXElGvf8EcvcnY79K2MwgRCYkV+ki2DF7LmnmkZhdqdD
         68LPGNEM4G77A5sWpApZxg/qdCt8R6RDF2nPbPZy7F45eoOPv1imvFR+V70dp28zmILX
         20izqh722ZZHyxHTOh8dSDlKoS8sbSy7RFWsWMq2bl/ZiHMaUU34KBAQ/3Q655PL7kWd
         BHScWxZ4AlfGSKwA2ep8SGYW1N3ax9p9xXgFjOZqf+PTIFym4FtS4Fquz473O4oJ9C1v
         LCuZEAHkxExZJ8m2Ny5hWjTh3bTNCROWYdkp66Gr12P8fYloGxuQkpdSanxzb8fipEhz
         FxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793135842; x=1793740642;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zj22U27fdgZfpXBChZKoCg3JgtYeQCimM1Wx3cOZywk=;
        b=0BWHnYabo7T3SHs0mGTKYyJmBNNzjx6nG5EOohhmTJVFrl/LTrjzp+O4HN/1XuvF6+
         Y15ymAwHEvbRWzFfp10+0kDPiI+BfJydpItLH707WXgpfWkLeW5rHDec6UYX+IjKhFPL
         zDczBbBxeSOtlD0JiSa5yjcnoppuM59kLM40AHH6cZs7+SKWCWOHFM4YZk6lBDcw9sD6
         Lji2r9+JyjKqS62VBmS0gwtwZswagfJqEuZm/2nl8Tp5CRDJO6yo5+dzCTK20aMvlHPB
         b7CidShcQEVV5bLXEHQECopxOachNEO539+SUq4y18iebBNv03d46BBEN73w5kZS/O9y
         P0KA==
X-Forwarded-Encrypted: i=1; AKwUvBxWIpj5ziYGmu6YC2jTiU2zTfajtdCUYv2agasd4QV7B1lJcFyWdRrBvvIOXA1+36HExRFGfhM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZSpOOM3eKhDzDkoGsJiTao1ZSYtDSp2bsNBr07O0vQKIte35t
	OMY1EohUXmkTgpBNv0sa5BqJyWaVLmAn/hFjenv9cPwFxF2TwP1DxKwH
X-Gm-Gg: AYBFou3HnAQZK+mRS7A4M8xxE/KxMuPRdJjC8JsU9GEbZtwIKQiF1KDgLAE/MaCQ3t6
	HyzLk5e8Bf1n5/SDKApP2maIHDtaQA6MdCc9CWGPYAmjYL7QCOyRrtA8uhTpgSudaD4KdbdBHIK
	3Dzb65r6SILsRBHcXOy01MY0EoOV8MKK3FcOZ/LqngF2FYxJmmieds9sQw4eLBVQvxH8/3yGvRO
	RYpVblfznFssNGpz+bPGJYtj7IWQQre12tmhZ0EmyTF4CIGPQkE++zNc2uPG59/7U30svKQlHS3
	6SNIelosDdLatTSQTBrE7WS9dT533QrSjPVo9IiHaB4CtKCHKBBpFVMgvQGZkh8GoMTd9F7L3Ft
	Ex4z34yKuriXOJQTujQsoGIt/0M3QRF+LXeHuI7w348pi4nN5fm0tQ23DCkHdu0OHF3CVj1hQeo
	jjqtZ9sxrJnJFXT6/Q/J9bBoR2Ysak5adFbN+kXyrEpWnB75mPEgdTEikc3ls3t3YCrVPuQ3mVI
	+kxKBrcyu0dsqft5npzYRv7bLOPi9yJvzeJhVTlnW20ojhQQUwq+nflFoeJTfilvhjIbgM4l8Wr
	DpUd1To05unU1VtS21Mp+XaRgTdDhs/tQlqc9YDVkk9Y1aRxL0FW4MZkbN19eoyczf+Y
X-Received: by 2002:a05:6122:179f:b0:5d0:e3b7:334f with SMTP id 71dfb90a1353d-5ec4ccbc8b9mr239071e0c.18.1793135842062;
        Tue, 27 Oct 2026 14:17:22 -0700 (PDT)
Received: from 16.15.168.192.in-addr.arpa ([187.74.25.171])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec2349ebd8sm12639658e0c.14.2026.10.27.14.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:17:21 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net/mlx5: macsec: free struct mlx5_fs_id after an RCU
 grace period
Date: Tue, 27 Oct 2026 18:17:06 -0300
Message-ID: <179313582625.87630.11382992904624255106@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

macsec_fs_id_del() removes a struct mlx5_fs_id from its rhashtable with
rhashtable_remove_fast() and then frees it with kfree() right away.

The TX (SCI) table is read locklessly from the transmit path:
mlx5e_macsec_handle_tx_skb() and mlx5e_macsec_tx_build_eseg() call
mlx5_macsec_fs_get_fs_id_from_hashtable(), which does
rhashtable_lookup() under rcu_read_lock() and then reads
mlx5_fs_id->id. A transmit that looked the entry up just before it was
removed reads freed memory.

Before commit d4ece08f4b1d ("net/mlx5: Maintain fs_id xarray per MACsec
device inside macsec steering") the SCI table held struct
mlx5e_macsec_sa directly, and mlx5e_macsec_del_txsa() freed it with
kfree_rcu_mightsleep(). That commit moved the table into macsec_fs.c
with the new struct mlx5_fs_id, but frees it with a plain kfree().

Add an rcu_head to struct mlx5_fs_id and free it with kfree_rcu().

The same issue was flagged by the Sashiko AI review as a pre-existing
problem while reviewing the HW-GRO for PSP series.

Fixes: d4ece08f4b1d ("net/mlx5: Maintain fs_id xarray per MACsec device inside macsec steering")
Link: https://lore.kernel.org/all/20260909065542.4B80D1F00ACA@smtp.kernel.org/
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Yaga Agent HackerSec Claude:claude-opus-5-5
---
v2:
- Drop the macsec.c hunk: the sc_xarray_element free was already fixed
  by ad17ad50b8dc ("net: mlx5e: Fix use-after-free of the MACsec xarray
  entry on RX SC deletion"). (Simon)
- Embed an rcu_head and use kfree_rcu() instead of
  kvfree_rcu_mightsleep(). (Simon)
- Fixes: now points at the commit that introduced the kfree().
- v1: https://lore.kernel.org/all/179285888829.90275.17386097105525068016@gmail.com/

Testing: compile-tested only (arm64, W=1, CONFIG_MLX5_MACSEC=y, no new
warnings). I do not have
MACsec-capable ConnectX hardware, so this was not run on a device.

 drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
@@ -94,6 +94,7 @@ struct mlx5_fs_id {
 	refcount_t refcnt;
 	sci_t sci;
 	struct rhash_head hash;
+	struct rcu_head rcu;
 };

 struct mlx5_macsec_device {
@@ -684,7 +685,7 @@ static void macsec_fs_id_del(struct list_head *macsec_devices_list, u32 fs_id,

 	xa_erase(fs_id_xa, fs_id);

-	kfree(fs_id_found);
+	kfree_rcu(fs_id_found, rcu);

 	if (macsec_fs_is_macsec_device_empty(macsec_device)) {
 		list_del(&macsec_device->macsec_devices_list_entry);
--
2.39.5
