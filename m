Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15823233E8
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 19:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971166; cv=none; b=o4bpgvdHAf88BLmuNCiZulNT5iOV6yPmUY2E3ioMmmAB0AhLyCgrTXSABMumgK6wkAVO+6MpYTPyeTzcco/Dro84O9xiEJqyMLEjgqnTAqxK4oO1msTP/myRiMLlABK10t2qACU16vQkBMKlftatCmtC4qM5YySMBG5G/EjY1gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971166; c=relaxed/simple;
	bh=2QuSqEoUZ44c+kvFpeJB9CUba/9zuKKEIRcvW88uZXg=;
	h=From:Subject:Date:To:Cc:Message-ID:MIME-Version:Content-Type; b=PyljNZVfeNXVyo7LkRBTTnBW0tobs3DPre7YJG3jlT6sBo0UlQIUbX3SE7y21YjDU7HdOvYXppgGvyiPnWAXyCz6SJnJ3K3Ja6hlvPAJm3O/GcfoeDDZNnoi4B+fIKFoVFkUKsnE2+cR9mYC9g5zZNlxNepBSqSp5waC3cOva/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1FfakCb; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1FfakCb"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78dd54610so3009373a12.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 12:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790971165; x=1791575965; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:cc
         :to:date:subject:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EQWwIMtmoZQ7CScJ9dS5e16+cQV3keu5noBHD+EyPXw=;
        b=A1FfakCbrM7XwJQG/eXOf2dYl4W0DS77NMmN6M0hDgnJtSaTUwZpaAxq4pBDVihg9J
         gWkdGml0s+o4hqSu9YTquoz8XxAINLaTnxaKjAuopCKXhIVNnxGIOZNqvNnSjfvWc/Lb
         dl3JMiYP+lq0w1mGp239XVN7XZsbg0vFVzVpBJMdtinIEBJJlZ2z0EQ13lUSq2MqEFXY
         PzUTzd0cJDqGA2qfAAKje5KR6a4goMyGqYVt8Av+HrhUOWqXpaXzvuEd9vPGf9vx82bL
         uApEA7povIsLVevfUK4ERvi/aFbAXyK/9ksUVmlDx4maPi+dJ+2s4n8afOIY7TMIaMem
         J5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790971165; x=1791575965;
        h=content-transfer-encoding:content-type:mime-version:message-id:cc
         :to:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EQWwIMtmoZQ7CScJ9dS5e16+cQV3keu5noBHD+EyPXw=;
        b=Vzbphtf+VNrKn6be8LhwdJxGbcsJY7Ccss/BvJcLb2MCQeUy+f1/x16f9TwbHdP4Yt
         xyUHnPmlNCW4iTR3AT/uMa7pfffHEs1VLfxAc4NGFzYnK1MsV/JlQhga0A3KhjsPTpZo
         afsQ0OJduqyxk0fcBOwNsIU2USSk7PC6MMLWlNuw5Xf9Mdut9Ii6l0WUumD/t+ZoiPOa
         egPJcD64xN2FwPVWoNwX0EtQc+NMvl6yRvuKzN/jLTs8fDo7nTNLgfl/4e10BgGgcTCZ
         q3wSejx8DZNi50HKk1+MObnr9GGH3247H7Vt8hzdSjbotmYPfIjwgFUn4svFY6rlh+WD
         ihTQ==
X-Gm-Message-State: AFq9FYIMY99YXfK7aaahcRtKTzZbmLcXYN5t0JxDS/1/4DqZaemdWU+m
	lLlFKGYc/2Qw/K7or+QvaMdzdQ1obdguw6F0IShQtHpkAwvBU9vhNp9e
X-Gm-Gg: AYBFou3GR+g+RpDNm5+oGJ1CTR0kjdI+aq1vDNlGcZySAB1o0RDygZnLb0wWZCSiyjT
	OCzcs2LsAiIAnRX54U70w9prDocP2/p3yjjzux57eGNf3W2c3M1hTXO3NEjTjf7SOPcDRUb0IZP
	mOkXITmDGloLSrJPMLcoYeCBhg6//IGtocBBCsS1xGWjnRKjr7HhBDJViYX9RWUSKZlrUVTTBO0
	96kbfPrL6HVk5IC6YzvMgRu01XuDzRhCmAq/SjA50VxjKEgs8z9pKI7og4WohKxWoUXvFpR6gd2
	v4u9dbDa+RxWZ7yebZUFwUqOhVlLJVZSDM8zY0YAO/PYG60tS8Rt6RsBqYBgou+Os1RHS7JfUUq
	26nJejgA9Op1ctiivsRkyDor8tH7ieknHeFQsTysBlWKRfL5VXVK/zhD4VT+j8MCxZvgXLyLewk
	Vdvq7kWQj2wYgbL7JdjjBF8KhtHXV+1Pstt3F/EeQKcznCpMJi2gZeSDhoi4Pi6/Trgz+XY8Fmh
	9qjg3RKPLWAAp3RR2ORDxeSz8Tj6BzvlA==
X-Received: by 2002:a17:90b:2782:b0:3a4:adf9:5d38 with SMTP id 98e67ed59e1d1-3a6ce356a43mr1386542a91.4.1790971164727;
        Fri, 02 Oct 2026 12:59:24 -0700 (PDT)
Received: from SANGHOON. ([1.220.132.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6c8421fe4sm5419796a91.12.2026.10.02.12.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:59:24 -0700 (PDT)
From: Sang-Hoon Choi <csh0052@gmail.com>
Subject: [PATCH net] mlxsw: spectrum_router: destroy FIB hash table on bind
 failure
Date: Fri, 02 Oct 2026 19:47:40 +0000
To: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Changyul Lee <lcy8047@gmail.com>
Message-ID: <20261003.final104.6f67a6ed1c4476b7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

mlxsw_sp_fib_create() initializes fib->ht before binding the LPM tree.
If the bind fails, the error path releases the tree and frees fib without
destroying the initialized hash table, leaking its bucket allocation.

Destroy fib->ht on the post-initialization failure path.

Fixes: 2b52ce02e1d1 ("mlxsw: spectrum_router: Remove unnecessary prefix lengths from LPM tree")
Reported-by: Changyul Lee <lcy8047@gmail.com>
Assisted-by: LLM
Signed-off-by: Sang-Hoon Choi <csh0052@gmail.com>
---
Compile-tested the affected object with x86_64 allmodconfig
and W=1 (GCC 13.3.0). Base: mainline 3b7cab693ba2bab63774bf5b988e8a61b2ef0f32.
No hardware testing or runtime failure reproduction was performed.

 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 3d6fdbab05e0..456c60b9be17 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -556,6 +556,7 @@ static struct mlxsw_sp_fib *mlxsw_sp_fib_create(struct mlxsw_sp *mlxsw_sp,
 
 err_lpm_tree_bind:
 	mlxsw_sp_lpm_tree_put(mlxsw_sp, lpm_tree);
+	rhashtable_destroy(&fib->ht);
 err_rhashtable_init:
 	kfree(fib);
 	return ERR_PTR(err);
