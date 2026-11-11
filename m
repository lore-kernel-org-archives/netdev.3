Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389453;
	b=Y2rP35keSMGBTuQ1tTEyLMl+Q+W0bgWyLb1+jrLrfQZtlbT37cSgbSoVOx0nXz3QhDd2
	 xgmE2uD8Nwh4HFyiq7rpnaG0GlYlHx3Ive9sHveVfiySttFLMPvaiZ2Nlx6YJnX4mLNF8
	 BNON01wDmqzmsCWAp7VEzxjtDBCbV662ZOLstGobrc0ZjC4PuTcSdZ5l34l93Cv5qh51u
	 qHSeiBl8RfzwZWbnNQAP6Kvg2fZ13RUmFdKua8yscyTNZOK1SAnQYJi8fyYZDq1SuGiAk
	 7NOAcjOXuxSCNKpIOW01GrNnKWu8zhums475RYvor/FX6wziKJTPUHe+AJT9D1OV6eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ohdbjek4hr8Jhs6bONF/iNmbouRA5J+FWduvFT7IpeM=;
	b=Iite0f7u+V0ofUymdSiRsaHoXSAIJ+Mcy2ui+VCJQECm65YPErz1ZTVPijeIAHDgOKPD
	 cTTJPM08IqbYkhh7MEa0ixzsoKOq61fdMPlptoqvgjX2fmGvaa2S6NqHClMrHoDQ0tzrf
	 MXG8vJ2cY19kyHvWOcYPI6lOLzKMyo0pAjpHfiAh/W+CN1Xl4HamgmgbubqD0dHLgI2I0
	 J2KMeGfhBkEeZO760EU4dxgfpf8frG8eCOx1PiPDoI+OoB/SRh7RORx1YX200ak/led9n
	 Un+lnX5iwAFKlSTrOYVaSYftJPQdwFAXMhvE1EZVTA5+JS61kPW5hTv6w9DTMVJHzhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fqrgW2iX;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660EB606A333
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 09:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 660EB606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fqrgW2iX
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso1584072f8f.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 01:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794389452; x=1794994252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ohdbjek4hr8Jhs6bONF/iNmbouRA5J+FWduvFT7IpeM=;
        b=fqrgW2iXgHIJeJhQma2d8o1vZNeBqNbbG52ROBSXr7B/rKI6naTwS/dn5wgSlDXWyY
         v/ZQuKpMBHa7ZQxHt7ZeAfqIImafnW85f4Rc39C8m/lCZsstB3xUd9BbWtoX2dIHhB+g
         BhO5+RX9d2HCuar+UqD9j8ByYscf5nN5vEkO0VGjb1KLKc6Iex/tpGh8j3AnF6xfhNjN
         ZNLVuPm5/XyQ2CIY0HBr8vPI7Z14LXZFNOk5NpAFsJOgD7EPc20Ox7Z/9IFWcTUev6Hr
         Exm7B0B5OWTFlFbwj7M3W0PHhe6AQrmFle3vOCwPN2DPjV1WpA0n7PXQk5kZEC0jnC3t
         t0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794389452; x=1794994252;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ohdbjek4hr8Jhs6bONF/iNmbouRA5J+FWduvFT7IpeM=;
        b=s9VxtId6iOycz0XzlUJwjzO5cu0bMEHaElicAhiCpH2jcNdZOYB1+47RrHh1172cjk
         W8LalegaMm+Qctagfa3/2HCNl4h3rl+sZ2L0UeoIcP4d9lHab6WFRiS8xng/h2Fz7bLP
         npRxXXklAu/+ZWJzbL7EitNUA0d8P1iJVvJphZFwVvp7EgeEmYq4mNBwvrRKP6dqhEYD
         NKDPPhM+mJZY/ffmJ5yRlEbBsKx/M3mu18b/0zNiSHwSB7UJf16wG3GKB1T0xPwi0SVN
         1Ad7UKOswDjNY4O+9D5GLFhpuyRUBS4o/fY/3QWuz75TovBw2gOxnxk2l+IxWg41Vl+l
         V31g==
X-Forwarded-Encrypted: i=1; AL+hErEdIDLhjPMzSXYs/+cwQVLi5fquZ2XVLGmGydEu8ycpjBGWJLwpeL0vTu0XEurs3sMW/yRSKEY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8mwJqSnFCYNVtAB93r01zXsTJ9MEX16VzA/q2k99Bx0mVEIMyT
	/vYJuzJHBrxHZifk5oHK45cKryMDWbRXXbu3rBmAmoaQs9tTp5DwFEdmK5FkFZ8cfJY=
X-Gm-Gg: AYBFou3gYQg26GTtZ8wbNUPQhRhMH0crvmLnv+HccAZ6Di5Ov6uX2evivaTmG9rQA9Z
	wlEGgxgBT9YF1M7h4JUNvL/mQdd6KP3CGPAnqKOdpt9UPelGZV3ylZVAvU2BvkTDv2OIW+688Nq
	JEFzAi2+l0ASpHZ61oZQJZu1fnIPFYNqrLOj/atAn3g5UZFqgJwLRq6/TCYWWdiTKe+amNKILYW
	Cdvwud8VekQpCOYRb3aP3ZRsOwwINpeTNUkeiuQpDCxu+Grz+gxQtEyUkpud2RYupWkBW5/5YJn
	fRRPaWKOAAHXyyOn9aFmAoIkM6pZosMRLjb9mU5KiXf49ZbK67m9GPrnbBOmcsaRShHtZnNX223
	GCoYtMZfE8ycmO1TZzipZP2a2+JNwdbOSYjTjrvIdCs812GTiqf3A0z1Yd5Vz66PKL+XLwrHF3B
	OA8DhfeaYwu+UXfRhtdJGXYyUd6sJsWLDZEhlpi0y2fPylRijQ4mkh7DflrOyUIJMx/4UsZGxei
	Q61I4ePe/yRU1lBWTKL4lmdVBI3d/cOSamsiuSnS9VmenshB4hExQr4amqBz5naOsomNdmf/8Kv
	AQSHixoBBqGT4RxkxFlODw6iUHk6/8OohE8dIkVD2wBqSktaMVxW05yIG3DgQdGXPKYzArkv8yG
	9Yek8Y37Wt/xU66sIxqVtJR7zvwO98biet4MnF8ETaFNpki9wrk3kf/rJZCl81wXQuoBSMoBkvG
	PWRxU1/ZNpTM4=
X-Received: by 2002:a05:6000:220e:b0:48d:ff0b:9b52 with SMTP id ffacd0b85a97d-499c72712d2mr3050951f8f.19.1794389451603;
        Wed, 11 Nov 2026 01:30:51 -0800 (PST)
Received: from AHERLNXVDANI01.lgs-net.com ([193.8.40.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498362eb14asm9175839f8f.34.2026.11.11.01.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 01:30:51 -0800 (PST)
From: =?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	dima.ruinskiy@intel.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>
Subject: [PATCH iwl-net v2 2/2] igc: treat I226-LMvP as an I226 device
Date: Wed, 11 Nov 2026 10:30:35 +0100
Message-ID: <20261111093035.513635-3-danividanivi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111093035.513635-1-danividanivi@gmail.com>
References: <20261111093035.513635-1-danividanivi@gmail.com>
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

The I226-LMvP device ID (0x5503) was added by commit 8f20571db527
("igc: Add new device ID"), but when commit b8897dc54e3b ("igc: remove
I226 Qbv BaseTime restriction") introduced igc_is_device_id_i226(), it
was left out. As a result I226-LMvP is currently treated as neither an
I225 nor an I226 part.

Add IGC_DEV_ID_I226_LMVP to igc_is_device_id_i226(). This changes the
behaviour for I226-LMvP in the following places, all of which now
match the other I226 parts:

 - igc_probe() and igc_io_slot_reset() disable ASPM L1.2, as done for
   I226 since commit 0325143b59c6 ("igc: disable L1.2 PCI-E link
   substate to avoid performance issue").
 - igc_tsn_enable_offload() and igc_tsn_disable_offload() set and
   restore the I226-specific RETX (Qbv full) thresholds.
 - igc_tsn_enable_offload() handles the FutScdDis bit and the base
   time as on I226.

Intel confirmed that the I226 TSN functionality introduced by commit
b8897dc54e3b also applies to I226-LMvP.

Fixes: b8897dc54e3b ("igc: remove I226 Qbv BaseTime restriction")
Link: https://lore.kernel.org/all/5d45a583-198c-467d-afbe-8f19398e82f3@intel.com/
Signed-off-by: Daniel Viaño <danividanivi@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index ab9120a31..6865fef40 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -447,6 +447,7 @@ bool igc_is_device_id_i226(struct igc_hw *hw)
 	case IGC_DEV_ID_I226_V:
 	case IGC_DEV_ID_I226_K:
 	case IGC_DEV_ID_I226_IT:
+	case IGC_DEV_ID_I226_LMVP:
 		return true;
 	default:
 		return false;
-- 
2.53.0

