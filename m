Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5854A49AF
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 19:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106525; cv=none; b=rDjwdDSbI4FDlePLl5+EWjUoveey7XTZgSZnqlknTn+icer4MiZg3yKv2Cf+rYCbiFp3OVL1FilL2kAp7RVoAk90lt24pI+Wt1I7lDLV01GJxgafHsc6+SukAGuc/O4fuvYanNs61VDe4sI3Fx6XYfpUptlsJsSF7UAaDokC1MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106525; c=relaxed/simple;
	bh=jNQfUoCT0rQsQDqvqd6O5D53mFke1F/vMOIqT2BbWDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TQ04BcFL0rIQEx7VbV7/Cg7/Ex8KXJDU6SYvdVhYyL4Br2I4aXp9cs2QdOZDAWBgWnokx6J5ReVGO0c5oYqz+lpUYynpIjoQNtll7QhAVZOGijUofo/f+FxBXZJPkCTvpgfMe3fHjL+5GladmNJX7JZLfuRqUJnz89mJ6DIC3yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=gU8c5Hm7; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="gU8c5Hm7"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-1438e88300cso206122c88.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 12:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790106522; x=1790711322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iWpsGs8VSxj7CDadxY03DnkBRPzm3FWyOuoPzRkUTdI=;
        b=gU8c5Hm70qVVuw24l07nxO3NySfo7ayObbRajNacpN4vIqkrQyUEiBW72XVJaNrHYV
         vQXwGb42GnE2asbbwBf6YD8PB4l1z8WN3+fjt2mL5vIZVBJo0ZHghTh5ckAMM1MHfA3W
         HzzBl5BnlfDPKT1K5YUFXdofQtCUkDDOuKuYqs8V9XOZ8Ep4E+w+3Zq3v1E1h8h0hlil
         ojGePFK4+P46QfDRBYKs4+ufujkWeaoyf7mUCMplo5u69GWI9ddv+5Bn100Eu9b0PC5c
         m09kNZlohBxIbiIFAS0hFP1Q4sZxGSR29WxLh4v13ATFxKw1NbXcRwzP81SLLCIOGdLx
         F0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106522; x=1790711322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iWpsGs8VSxj7CDadxY03DnkBRPzm3FWyOuoPzRkUTdI=;
        b=QbJFCl7tLIEcmIuh4cgjVtlN+FZb62KZdlh0d7t0w90Sclq2BtulV0Lw9cPYRjN3iI
         /vZCzIa9vaQAePor9tNqCHsiKUFFdV212YfKR9TMkis/RD8pKdwi3ngVJHxAw/RwTOfW
         kSTRLboJnWLjkDqhD1R99dK0SBVqXpH1M/4XzRSVVQY7E0osJkWiTqT9mb7Ka+JtfNrh
         btRAMzk24GVkwEl4Gvl59e2UH6ZKvhF90LNl1QzGqgtPNAeygFwrEQxbH4PbC0PHNEYr
         k99EBFUL4jz8FzbGBMw2V5oxmZgPS7JIxiygksPU6aqPV7k/ZLpFQzdpxRFEidE+QKQh
         TVaA==
X-Forwarded-Encrypted: i=1; AKwUvByvoJq69mpp7kjcw1mo4NRX5rbAFT+ZPSH5DukWgPWZ52d+c8NPV1SGWHQuQIq7EEM5wZcE8ZY=@vger.kernel.org
X-Gm-Message-State: AFuF++lDJkOdHLCJ/idAVrEsR5Ef+cZlYME26658nHUaXRge7y6xD/O9
	7nXjV6d80Ru5/TnXDxREmNv6HKKuiRiucbrlpZ4dkEHmXaTlc6tGvzdie0NJE9NgMTQ=
X-Gm-Gg: AYBFou2x1U/Ylrd0anLA57v4p9kHIyGgWNFt57W8KVzI3b3vtxFdOBxG3s7eiF7qkGr
	oGN2wV7u8It5byA96oE6oBq9TbEBKeRTmh4QBT+6w+87DWJG9/EEhykTNGdX95/AS0vLPmMqmlx
	8bfQCTkpbRqqtJu38I4P2xa89cLDo391PKz4gxaREa978yI9UGJSvv4k3LhPbi5TNrupiXUJSNY
	4yQ2tIgGdvMpdlGxVvbey/LtfixI633CGTOWk3Jw03yQs6KeaoC7CU9ZNR6ifV9MQCLjqwaBXxm
	K83kkmC19AV/0wqF9hdjETuKjwVvFjj0x6q7ChKAIjTph6/xDuyKA6ziOe8v2N/lwDRc8YBV8nu
	aeJ/Q+Cc5746JKKQsiiydX9HlaFZ7sWaUvyQQUJ/WK39cI8xcYqIXd2onk0kh/i25q4JaY8RBhF
	FdiPYgyGPk4KWQHjL2L8iuCwdFWRt5vAOnhb8UOEO67y/DAis75KMvsdlDulXNMnxZnAWHnfLoe
	ZBMyna4Gnh5wR03oX5kz74+r3Em4CcyfysiztXKXSm6nd9axgF8cOJ4pdtTCYfa4mPRtX0=
X-Received: by 2002:a05:7023:a5b:20b0:143:2973:3cfe with SMTP id a92af1059eb24-144f91cb630mr410014c88.31.1790106522287;
        Tue, 22 Sep 2026 12:48:42 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:c016:77a6:d382:7611])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f98a288esm708550c88.13.2026.09.22.12.48.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 12:48:41 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 6.1.y 0/2] Bluetooth: backport CVE-2023-53762 to 6.1.y
Date: Tue, 22 Sep 2026 15:48:32 -0400
Message-ID: <20260922194838.26223-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha, and Bluetooth maintainers,

I am backporting CVEss still missing from 6.1.y.
This pair handles CVE-2023-53762 in disconnect-all cleanup. The
second patch is the immediate upstream liveness follow-up to the UAF fix,
so I kept the two together.

Both changes are already inherited by v6.6 and every later mainline
release.

Could you please queue the pair for 6.1.y?

Thanks,
Artem Dinaburg

AI assistance: An LLM helped find the missing CVE fix, adapt
it, and prepare the draft; I reviewed the code and build output.

Luiz Augusto von Dentz (1):
  Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync

Pauli Virtanen (1):
  Bluetooth: hci_sync: always check if connection is alive before
    deleting

 net/bluetooth/hci_sync.c | 58 +++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 21 deletions(-)

-- 
2.39.5

