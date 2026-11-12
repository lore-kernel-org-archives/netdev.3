Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794477893;
	b=YeiM26ZIol1mJ67SOa09xHR7hPzKKnsiPTbiwaKEI59w7eA59zGn4ABMl+qn7y1SA7cT
	 vS8fBzGU9qlyzbXFnmIzuMcwM4Y9+RpJQM+gfmsc98GjNoesA1m4lLsjYcz3XZ4DuhjCp
	 jfJUlBKpbaYG+yQ+3KSMxlTxvQISvDc1w7+oyD+IK1VvmQh5E21zaoifzich9a2O3BSyj
	 isGVqA4XS4i03LSp16WdoDoXoyrNm8gjNa5cTocTSiSkMtzXyzsmL90krtjh+HkfAZYxN
	 wJwXX3lZf6H7V3Wu+V2jF/crJMAQj/uzarYsoSwc/vxDe3h7vlxZcH3pVLTmlmBtgGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794477893;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=db7y3lUD0vRJWmENghI/EzWxAuhHhCQERcund/ARCN8=;
	b=bwYDV+3F7nxIlkK1TG/D9ynI5yXs8Y4nDydFhqxtIvKIzT+F8z9r6Yl+36bJvQioJBbp
	 bzUl0zc+FHa9UP3VQDZWw1w2EAiLGtYZgVZpfX/38y7if414+8o+jLVQJhsgsFEy948En
	 flJX52lp9CH+n9bm9BoEH74yGMYOBBfx3JU+enck86cd04vzi4ogiZ8u54HJxqQoy1SCR
	 1WlfEhqtTCatbb3gJSZy9oQpLg2J5JUipPJTVqsbi7Gg1cWgTbbWIQHglSoARTvrARAes
	 AevI2roAiw5483N63t5m48aSbr45vDrOKce9ZGPFWlfsWDPaKS+1NIJV/vt7VKbSt7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UR0pf6b1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A286F606A332;
	Thu, 12 Nov 2026 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UR0pf6b1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794477893;
	b=ebqh0/POhcVnNHBTjJC6Y7QuNIb9rboDo8nt/3KVCDTVXo8jDVCJcdal72jZHSLbYy+J
	 CGW9NlezbRFZAuzCEiNMvynnMALfX/3l5SrMzVbV/T7emt/lD53sBT9xiTqQBjK4sNFxK
	 ECUqU/zCFR5UZ3l6I33ZNhvu+wnuYm/lhF3NzM9OEzs4ZaqbDA1QaAhV1VgQB1fKq4i9g
	 FH40z6KfWktt7uBrWyLpYNRnW+wSCitqbzBOPFY8TN/QpDJ9eb20fkHuGdDQZiBl4WCLK
	 ao8K5zAI+qxMoyKY+w3KmAI7CmsUa0VQ6N+96NyxHU2/Ynhkky3V7a+4c1Ha1ZU8rBQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794477893;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=db7y3lUD0vRJWmENghI/EzWxAuhHhCQERcund/ARCN8=;
	b=F85arTWL2dVsO8T2FF2B/h/8uwp4wLhWSUj5J534EWXVgbHKBrKYD6KyVNV4NcUDm50X
	 mUoXtFmQShOPD8UX+e7vHRPhAQMOX467ZbWCO3m0tsL7aYylm1N54/2DAJG1Gs2Uj0nra
	 mPLuU+pOdYScAsz51zaKTBaL44i3veMSF2KEdHrOJ226X791OSTu8U5CXr+IVNo1bx966
	 f50ZOMjFsBmNbqjYvnLViUfY2FSJEBsEBYLs6Vi+pV9TbHOdE0uFsO20vjvFKt2AlRgrS
	 EgPCGfovneqYvUMqVos/dX9YXmWfI+F1X0uNqVPYNlQggffgPJsSD+F6PXAhEN98xOg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C67E71F00A07;
	Thu, 12 Nov 2026 10:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794477893;
	bh=db7y3lUD0vRJWmENghI/EzWxAuhHhCQERcund/ARCN8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=UR0pf6b17j5I8nOdAVt+Vb9qtsUx5wW9GvyjKF0Mo0nVwf8y5YhJUjXBPXfmNzYn3
	 i6ZErWV56cjIyFC9haSsgwJOQ9x2nfmme60sTLd7+7HjEjvowco5meXaNW1NlArgbm
	 N2FosjgnMLd3+AgCBwOhgvU7aBWFV56eLmhP9cMEPe46F3Aa19Hhi6U1SHs5j0KDaA
	 u1On89o/B2kdUMLehovlgLY0ZKaX6J8KQG3NqedIil+l9OYJS4z8MkKeOxkvtLFAHq
	 YJCELePd6M257TnVMhT74u2IS3HDEabfRYO8zrlAeAcMAPBWCScoMjWBCL7s/HmGHb
	 jFUhW39nQuS2w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 53B6649460;
	Thu, 12 Nov 2026 10:04:52 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 10:04:49 +0000
Subject: [PATCH net 2/2] nfc: st21nfca: Free the ATR_REQ skb after sending
 it
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
Message-Id: <20261112-nfc-v1-2-ab0ef166f382@gmail.com>
References: <20261112-nfc-v1-0-ab0ef166f382@gmail.com>
In-Reply-To: <20261112-nfc-v1-0-ab0ef166f382@gmail.com>
To: netdev@vger.kernel.org, david@ixit.cz
Cc: edumazet@kernel.org, kuba@kernel.org, horms@kernel.org, 
 oe-linux-nfc@lists.linux.dev, linux-kernel@vger.kernel.org, 
 pabeni@redhat.com, davem@davemloft.net
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794477891; l=2188;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=+RGyFbOPiqFDpQv7ZHyszj7XEOri6aHfSCc39zfhtRs=;
 b=v4Q5/lkOcsxVMVNcmaaspSv/zDgC3XTBcWhvnWhrbELGF9dTgrptheGZdcFIJhpfGv6haKGzY
 uI2rZzK9QrzD68wZ9yNInIGzjnqBilkb6ThDTTqi+GTfybqECLuKdLU
X-Developer-Key: i=shyckless@gmail.com; a=ed25519;
 pk=pMtccVGiWES3bV+7YBFuBclkvq2n2HBHQ5azaBrK2lY=
X-Endpoint-Received: by B4 Relay for shyckless@gmail.com/default with
 auth_id=1498
X-Original-From: Suyuan Wang <shyckless@gmail.com>
Reply-To: shyckless@gmail.com

From: Suyuan Wang <stevewong@hust.edu.cn>

st21nfca_im_send_atr_req() allocates an skb for the ATR_REQ, passes
its data to the HCI layer and then forgets about it:

    return nfc_hci_send_cmd_async(hdev, ST21NFCA_RF_READER_F_GATE,
                            ST21NFCA_WR_XCHG_DATA, skb->data,
                            skb->len, info->async_cb, info);

nfc_hci_send_cmd_async() copies the payload into its own fragments, so
the skb is still ours to free. As it is, one skb leaks on every ATR_REQ
sent in initiator mode, whether or not the command was queued.

Free it right after the call, on success and on error, as
st21nfca_tx_work() does for the same call.

Found with a static analysis tool and checked by hand.

Fixes: 1892bf844ea0 ("NFC: st21nfca: Adding P2P support to st21nfca in Initiator & Target mode")
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
Compile tested only, I don't have ST21NFCA hardware.
---
 drivers/nfc/st21nfca/dep.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nfc/st21nfca/dep.c b/drivers/nfc/st21nfca/dep.c
index a5fab4fd5129..4b9054eb0208 100644
--- a/drivers/nfc/st21nfca/dep.c
+++ b/drivers/nfc/st21nfca/dep.c
@@ -496,6 +496,7 @@ int st21nfca_im_send_atr_req(struct nfc_hci_dev *hdev, u8 *gb, size_t gb_len)
 	struct st21nfca_atr_req *atr_req;
 	struct nfc_target *target;
 	uint size;
+	int r;
 
 	info->dep_info.to = ST21NFCA_DEFAULT_TIMEOUT;
 	size = ST21NFCA_ATR_REQ_MIN_SIZE + gb_len;
@@ -547,9 +548,11 @@ int st21nfca_im_send_atr_req(struct nfc_hci_dev *hdev, u8 *gb, size_t gb_len)
 	info->dep_info.bsi = atr_req->bsi;
 	info->dep_info.lri = ST21NFCA_PP2LRI(atr_req->ppi);
 
-	return nfc_hci_send_cmd_async(hdev, ST21NFCA_RF_READER_F_GATE,
-				ST21NFCA_WR_XCHG_DATA, skb->data,
-				skb->len, info->async_cb, info);
+	r = nfc_hci_send_cmd_async(hdev, ST21NFCA_RF_READER_F_GATE,
+				   ST21NFCA_WR_XCHG_DATA, skb->data,
+				   skb->len, info->async_cb, info);
+	kfree_skb(skb);
+	return r;
 }
 EXPORT_SYMBOL(st21nfca_im_send_atr_req);
 

-- 
2.34.1


