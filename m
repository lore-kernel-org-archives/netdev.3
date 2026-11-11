Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389452;
	b=w/0JuAsKkjzSDEd6HeWQASgD5+p9KJbD5T94cfUuBPekQDOwZS4ZQGpOTY2kuuOujFZ2
	 JFrprwC9SKJLIGJ1HbyGMS8MTmkwWB/6tNmGJIifIJFQZ7A3O47Lut35DLMGYvY5PISkc
	 XwMNIAm7k3/e5iXepsD2ptpc9nz7vsr7UzPaqLUxj+N4bEbjyhCfJGJrCdi6jt/RUgsIM
	 +gAFBURA+z7V7ls1Jx2QDvdIToK4dNxxTxbr5Rfc+Yhir6g0zxf4p3rZUNYaRsaq2V64n
	 Wy29NdBUy4+9tFTi9Lg5SzXsWZ5F6sl+OyhhFnN0AyTmH61YTsZV33q5s6siBfT1VCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=B3ZS/U6BiBBD5fGeH1R5VkY9NPLOvEtcvatjGhH2bZ0=;
	b=siq67vuz7rs1vcT7gwQcSB/qE+HssYhk06ZBy5iOD9YGJiYQHXI3IzJAzE1QireJbxID
	 5fr0+e0PpUKvhKOJ1mXUMDnfLZM4796COXgs0OHclUvbU9Jbi0XeAMFdSJc3wF95aLuug
	 b4iMPYmlsdlx4o1bvCzqH7yRVVzK5llBehiGKNgjMDtVLK6HcsXAJ2uRnLEp3lSk/9zmH
	 fc2/6CHYcI3+rv3ND2CGefb4OO3hjpViH5FLtRO1VXkR3f878jsX5oOLkNxg+BB5V+U+j
	 zkk+U0oPDRN2hx/mBod6AwYi/t64KYINF0NUS6GOT2zda6a58usuN9QUjWCaEmDcp1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bjJSDUbt;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99F9606A324
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 09:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B99F9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bjJSDUbt
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4918c2d727fso1612881f8f.3
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 01:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794389450; x=1794994250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B3ZS/U6BiBBD5fGeH1R5VkY9NPLOvEtcvatjGhH2bZ0=;
        b=bjJSDUbtOzaOAQpSLf50C7xoz9mpqk5qHohnCIlWIv+4dIzFCWT8uBWQH1BMHIwq92
         Sp0skk7bQEZLBgS9CBlRt3NPDx8HuxaDGWyvWfkZ1t5b9SklX5+Z5vQDrp+iOrJ3CWzk
         5anlnWL/yOmkvajDxM0Sfb0kdjTXD7vcoBuTVSvmPr/cSe5SV0IKMaZEs066FbMiPLUX
         Aap9BpEE1/6enil0jBizKD5Uh6mVeY0FLVDtPivV8kKXMLwefcdUh/80Q5IJTKpbNejz
         jXcY705DjPDXEcwVQ21YLgF81sG8rxoLoWlBnl9XRE0iNOJ6xgfV2KOcCCdcTYXutmYh
         s9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794389450; x=1794994250;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B3ZS/U6BiBBD5fGeH1R5VkY9NPLOvEtcvatjGhH2bZ0=;
        b=hpuyYvnSr6c2XpKb/xVSkXY+vsQJ6OVc/oc6rSERi9l5KihLLU3UgvFSMiRBnuPi2i
         Ig0QKrw5yhJAfOIxmETSCr5QPMgfT8eZqispTH89fe8p5f7Rk8FuLspVMe/cHHMmqX5y
         uGzgFT4JZt+dbH/L6mBgZGfoUKCbi267K+8rDEzVsrK9KFMawRIqiELr+340m0jWO3CD
         rVMNhVAnl3jax3wVYfkyphx7CcLC5Ve3DmXcnNw3nJZFXnbcHE6PVCjtXNDkRDC7a9ya
         mlApQo/JbPDmr87agbvc3jubAWMowQG7LEWh8u8A7XmLLz6xD1Lb0A9QhUJvvjtisRDY
         6SmQ==
X-Forwarded-Encrypted: i=1; AL+hErFX02V27QLEF9HoPeAtSXyY9JNtH3mqbFbbVd79Uo411pS/kj971QYrxsdCmKPBB/ehEPA+s+I=@vger.kernel.org
X-Gm-Message-State: APuU4Z9h+b3rrfUcYbt7HDRi2qPFyhG2Y3IMi30A4/EwB/VmMV5g+r2+
	u8BeFFtDZ7izwTw5cs4ExwUJS92XvunM/MILc+C16PPSNYr3rsqpTdoU
X-Gm-Gg: AYBFou1HdGL5CXEze7XMwmbQJMTFd67Nl9ADUMw1k/vSUeOD02//LPPDKzLZS3vxj8V
	daVpTVbSX9SXL22YXn8ouk9qrddkGV/Rnh6Taxb+8Ihf2hOQhR1rbmgd1OSzDgk3+24n2r5dfG/
	vrzvmdD2R4/69Qm+D0FPoCIHTXQN4E5c5m9gClHwia0pa4fDxTwIBsBf+ZhooKMuFOXv85Keegp
	L9xDKrw98qdt0ZUym3vSBAZxatTRzIyqK+bCElM1+HBO1v9zgNjqn5HWXcW3L5yeBK9BeTqlkdo
	TPZXTW6JiAHn9QSaDrIh0zIMKhO97EGXCYKgCmbmFw5BtqePdeWqqY872zeQ/aajGAuHywMUuAO
	VHr0K96la6urqg9ZW0nuH5xf49wT0c+ONCWrJ6eMYezp4xYsepupjQAdcqucrfY2vJ+ViHLIUSS
	MXaAeFbXQ46J/EYCdBqaJcJf4qrJrtzw7vggH5MV+6jHqKtTvih1eAd7d/0Gmj2F/Xp4LtVxSSX
	6/JtvafmwQITTiI8sDD9HX29PDjosPpQ7gOK7q+ug+VAlzI62AOkvGfFBu1OtfUHKuR/eKFN7zT
	fKk9cUn6qa4I7axpL1QJJZNL0U0UAfOzlIrgs9qTtWdcHMAZKCbQZkPasf+XvQh9R6diyiE4+b+
	6GTbnD7Pc55wXycPrbJSEP+RBDx7lQAnHOZrP+R0wOyPO0iFovrNl1mFKFvCZl6/jGJ0m3V+C4n
	oP1htusDtc2TA=
X-Received: by 2002:a05:6000:25ee:b0:48e:932:aefa with SMTP id ffacd0b85a97d-499c630fe5cmr2820902f8f.26.1794389449756;
        Wed, 11 Nov 2026 01:30:49 -0800 (PST)
Received: from AHERLNXVDANI01.lgs-net.com ([193.8.40.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498362eb14asm9175839f8f.34.2026.11.11.01.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 01:30:49 -0800 (PST)
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
Subject: [PATCH iwl-net v2 0/2] igc: fix L1.2 disable on resume, add I226-LMvP to I226 helper
Date: Wed, 11 Nov 2026 10:30:33 +0100
Message-ID: <20261111093035.513635-1-danividanivi@gmail.com>
X-Mailer: git-send-email 2.53.0
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

This series replaces "igc: Disable PCIe L1.2 substate on I225-LMvP and
I226-LMvP devices" [1], split up as suggested by Dima Ruinskiy.

Patch 1 removes pci_disable_link_state() from __igc_resume(). That
function is also the runtime resume callback and can be reached with
pci_bus_sem already held for read (pcie_do_recovery() runtime-resumes
the affected devices from within pci_walk_bus()), so taking the lock
again risks a deadlock. The L1.2 disable done in probe persists in the
link's aspm_disable mask, so the call is not needed on resume.

Patch 2 adds the missing IGC_DEV_ID_I226_LMVP to igc_is_device_id_i226().
Besides the L1.2 disable, this also moves I226-LMvP onto the I226 TSN
code paths; Dima confirmed that this is correct for 0x5503 [2]. Patch 1
comes first so that I226-LMvP never picks up the problematic
resume-path call.

The I225-LMvP part of v1 is dropped. On the setup where I saw the
errors (HP Thunderbolt Dock G4), the I225-LMvP does not advertise L1.2
and the upstream port has no L1 PM Substates capability, so L1.2 is not
the cause; I will investigate that separately. As agreed with Dima
[2], disabling L1.2 unconditionally is not part of this series.

Testing: compile-tested only (igc builds cleanly with W=1). I have no
I226 hardware, so neither change has been runtime-tested on the
affected devices; testing on I226 / I226-LMvP would be appreciated.

The resume-path issue was reported by the Sashiko AI review of v1.
I used an AI coding assistant (Claude) to help with the locking
analysis and to draft the patches; I have reviewed them, compile-tested
them and take responsibility for them.

Changes in v2:
- Split v1 into separate patches, as suggested by Dima.
- Dropped the I225-LMvP L1.2 disable: L1.2 is not supported on that
  link, so it cannot explain the dock errors.
- New patch 1: stop calling pci_disable_link_state() from
  __igc_resume() (reported by Sashiko).
- Corrected the Fixes: tags.
- Changed the subject prefix to iwl-net.

[1] https://lore.kernel.org/all/20260925112850.189302-1-danividanivi@gmail.com/
[2] https://lore.kernel.org/all/5d45a583-198c-467d-afbe-8f19398e82f3@intel.com/

Daniel Viaño (2):
  igc: don't disable ASPM L1.2 from __igc_resume()
  igc: treat I226-LMvP as an I226 device

 drivers/net/ethernet/intel/igc/igc_base.c | 1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

-- 
2.53.0

