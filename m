Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223375;
	b=m+7+m0pDEPBifruLCao16zoolt0cOLUUba3exOnXZuXKSZ9nsI2ygQyS4ueonF074bx5
	 wcO5J1GoHoIRXzhhzvXJ0syJiOuaC8YrsHGzOC7AXUb7vRPZsb2AIUaJyo81DBGaRh787
	 Jw+Eo64o4ApTO8RELIZ0gajv65Aglv5YSU349dL+FiL0vim/skGn6PKrcAkiwVxL21JnZ
	 4fP9XqIFhMhKtZOzNkYj/zKuLDgUfNE2O4DnSUgnmQ+NVMb4I/rhVrpvxXMcY7b3ORFQJ
	 hrFrkLIVXgmRp9BfjpCB5s0k47cfntJiBripYWQOPGsuueRUo4KYw0zs+AaDei7jGYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=TPES/D+yM346rsmWkQERTkag+P/sb6E54p4Tbe06JmE=;
	b=rNOsy3fRShqK7xz51s4VQg/uCIguJiYHkcmpBC472DmQHfTAUn3FGaTzQYAT1lPG4G37
	 J5cJyyW+1Q8snMs4jXEIW9HbfcAkLf2iqwtzKqnWjUs5sIxcK59mhBnzxRSHaOG1Rsj0t
	 cxmo1804m9c9pvyRvOT9d6/Nny0speRv37P6kqvBZpN0qgLF2owU81Kyix9Vg3Jou4h1i
	 S8rEDAgm8o8Iz9CjkxyuvhrWr8eXBPgOhE358X06E3vkbvlEoTdk7sDphz6TXILPsP7NA
	 amclPAS/+Q3BN1VoY9j/YHqhVywy4guHEg3Oczb4RDuIGI187Pig0Y0w8dDW9env00w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ujmEkX+h;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179DC606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 179DC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ujmEkX+h
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso627141a12.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793223374; x=1793828174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TPES/D+yM346rsmWkQERTkag+P/sb6E54p4Tbe06JmE=;
        b=ujmEkX+h5g24dMaeS+tNm0ZE5DIWXKwu6DN7FyGK2m053A2VEuw/0GOVaSQ3SagmUd
         w/3TDnPk8PNsQaTAdMV8AhGiinhc/zqGktMyza6QqGbCrLdIaR7yGSCrXoNBE4Q/cJDI
         WGf6kmpj1Yef/aK2dhP1hllbjFYOsNbm/k//Xcr+pVUX7zzNkyr0ksl4Idz2lNNqKhWP
         0AarGjjObv4YqUUdnQCCe5jNvqjWx8lbsWPh5Q1mcAzWyPciJhkYB64VEJ/BcVfJ68Vp
         HFUJJEuE4kK1EBzwiDgrUNhf62aj9cfXtf9yfnrBh0a0ObWNul5FhkNfo3gv/bFXLdxi
         Y9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793223374; x=1793828174;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TPES/D+yM346rsmWkQERTkag+P/sb6E54p4Tbe06JmE=;
        b=GK3OB0bLeGk4aEYn+rh2Hbkj6Up4XfuQA9ZmuVsfoUhs/YJy62NxG6yNPUQhZ7/10O
         NBPCBj83aoc3e+LdAg7oooMQHWyGdkqrCVBxFAYUqulVd8ulMsuCuHz+pvhO+ZlAmR6y
         pdZ3jDVKURC5V86HRcqZaRolGPbVZaWTqxzQlL2rvgdnwy9OFeyMucya3K8e9HjRieFg
         bmScA/yUuiPv7lguaZ/Y4NmbHOYDxcq80c/MSCFzJ+8AQb3OCDhu35UPsAp4EkpZTCiF
         B7TYIDPxopUZP6C07mzCWfZ2cyVLBoajURS2OgC9Owp43bxLekWNNLKraEEz2G2H8Mrk
         CF3g==
X-Gm-Message-State: AFq9FYKnv+3l1cnA9NxzK6TJD9eTJtOrodbYyaftmsMEBNClD3i89m/N
	OGXxCU0TbtNyf7eLR4fUhG71jhhD6MLlw1XW8VgzdakR0QiNa5+RTYLn
X-Gm-Gg: AYBFou3ex98O0mofoU96TQgI8jXshswNU1xOVMF/LXQjzWCNHY0/vr+6YlxdnyDpCxK
	IyXWBR5G+cj0UTJf4Fe6stQ8W6rbHQIu1QxpqhGBNxNbqFGflRw6v0Zd56ruCpvzzSLeoCtp8Ra
	oIdzZHN93jqS/vWSHkcvuX1wW9Umii8ZJxuFq7EN8FKQNgqPPprYevvgplFEERObGMmlUFp+GWL
	8ZHAMEm2aczypgEyxR6vm6/oFbkIYYtqfzru+Hscn8nIJGG8BYeCwlrGf6CIbxpLz/6j6mOLTGt
	/K42PZrpJIfzuqA3uFPrF3V3nIarTi2m9gku3mx/y4K9LlwB9vY0L+LNws0D2+O+zZVL+DXU83g
	LCXiQ5kHQp2UomHW7w90Ji95OK+IZLU14u66u+q4VcPF+xMs0YhBtYOUwzMH7HlyGtFJT7Ukk5q
	ic1FeXyciyW48zK69RHif6OIdpeIbAj7Pxd/MgO9yMMjDUQPIbD6zXfNFC6Se0K3ceG8eh2JENS
	0e/83QWmYnmCURvjOdUOUcDMiDyCerJhn/Hh+yT507wu1WBG4IAMjgrzc9h07vFekrTAN/5zipx
	+sAWDp5khL3JzP5YIZb4yr8kfX1Hi4rL/kEZl2ZUns5uZtFxVipsvftyxspYCOj04YoKbOeTxVy
	tCUm7I7fMZL2/OjDv7BdT/pBK40kur7q8LVJb7+zmICK5SQ==
X-Received: by 2002:a17:90b:4b10:b0:3ac:aa8d:19e0 with SMTP id 98e67ed59e1d1-3ae57e07c39mr2926071a91.9.1793223374300;
        Wed, 28 Oct 2026 14:36:14 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7ac44asm1088336a91.2.2026.10.28.14.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:36:12 -0700 (PDT)
Subject: [net PATCH 02/13] fbnic: Stop sifting into a BMC slot once it has
 been filled
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 28 Oct 2026 14:36:11 -0700
Message-ID: 
 <179322337155.40667.17395928062035107124.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

The fbnic_sift_macda function moves BMC-only multicast addresses down
into the free slots of the BMC region. The inner loop that looks for the
next address to move does not stop after it moves one, so with two or
more BMC-only multicast addresses waiting the second is copied over the
first in the same destination slot. Both sources are marked for
deletion, and the first address is dropped from the MACDA table.

Break out of the inner loop once the destination has been filled so the
outer loop moves on to the next free slot.

Fixes: eb690ef8d1c2 ("eth: fbnic: Add L2 address programming")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index 939d56585b26..dc86b51f3583 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -645,6 +645,9 @@ void fbnic_sift_macda(struct fbnic_dev *fbd)
 			memcpy(dest_addr, src_addr, sizeof(*src_addr));
 			src_addr->state = FBNIC_TCAM_S_DELETE;
 			dest_addr->state = FBNIC_TCAM_S_ADD;
+
+			/* dest_addr is taken, move on to the next free one */
+			break;
 		}
 	}
 }


