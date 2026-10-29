Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793315895;
	b=DdvQggNS/0r66bCenQ1mjxm6tMdB0cmzRnzSh31h9PPY6UqxmqrsmKdwDQv2UtpNn+eX
	 v563eSghsbPqgizyU3VznTTePvnnsIKPnXlFEd1y+bWvrA9vaAZBgOzPeJecvs9Vfkf2C
	 rC8RhkxWZUS18Gth/PnqRfK9kAgZt1GErqt0kwGKRNDYd/2GLHAMMVOhjhOxrkVMI6adp
	 Vp2Wl1cj/JLql5I/lGdsUm4CV51tZRox8IP8FAyToWfaVHVVawI0c+pRvgSUSaFayJh8V
	 IFDKjeF4c2td1t5EwwrBKNg8E1eqJ6bYZQr+10rTCWmO6jn2Z2X50qiJO6KDFZExiyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793315895;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=lM+aGMHQoGHm+tWBHiCUU2JkCdwvd5cdpFbqD9BSPP4=;
	b=z7undeHIfohdTmItIflA2fw3u/KUB+dQqFm6vC3gwTlfRD1R0lCjVzp20EfHh+G2/HGr
	 XfmDNadXToBDBqwjm1Ja98DhGCYeo97UGqXJbMD+U33hGPQTHhlkfkP7nyCmR/lmqIQ05
	 WTk+1lNA3C48956CgFirHHaB94o0pQ0+mtRdJL0K66hQHRhV0lZ4gPBNBJPUyWVlTstzN
	 bpX5MYfmAO0xAHzYd+VZKYvpVH9Xd9cFW80vLGnQXRrFdvgQWTjP2q2xjKFUs//A1RQ+C
	 d6e9Cfcw7SFDpJf3CivKGTwkHrSLL+Mfe5wWvjhoB0HpadkpU8cEPw6Y6jA3rN1+FZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zsMpCzh6;
	arc=none smtp.remote-ip=209.85.222.45
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE77606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 23:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EE77606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zsMpCzh6
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-99071945aa7so66392241.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 16:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793315894; x=1793920694; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lM+aGMHQoGHm+tWBHiCUU2JkCdwvd5cdpFbqD9BSPP4=;
        b=zsMpCzh62pJ8Qbji29nhDyEkEY1fOuZsobLLBw/2xJxlzB89AlkdbhfnytcFhhCBV5
         9JhHi0eeXsZzlknjBuuFAP9e6MYmyYxL0maPn9WrnQc/pu4meVqfB4O+yjKkHZQgN8A5
         Lp/wXFsC9DxW+CgpiGhJOvWLcKHvMN8koX9aKl88KgfkMkoMmOkBVxvXfrmCJTSxxf83
         NysJscKl6MTOyeZUBdreIxwO4irVEI/hjSkeoIDi+CO8yvytYow8HQk5jpG8T63GaSCT
         1p84tqPaSUXwmHOHrIjTrsGr4JummFT8s2PB459byNxe0Q5dneUBKa39ufjQWPNeRK0R
         VwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793315894; x=1793920694;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lM+aGMHQoGHm+tWBHiCUU2JkCdwvd5cdpFbqD9BSPP4=;
        b=Zoazp4GtVXGW7ZTciBxeeF40b4146JNLP3+WXvVhxmAW0yYYOEunMARcwMioxmSCk8
         lYib/7IbicbusEEdKmfE2TqCyrK2UQFxEbLYkajYJf+H5ZLOcRu/aA7ncyz7mld4nJly
         Dy0E2XOWbCN35iNuO56wHT0LIwSR3jtchQ+b29G4ZSd1SZuvIL/pSlbDyjUvfxiNTpYY
         0Cg743iBiJ89hfDtWU8sSz3vaglScM/nSyEPy4NigiKLUcA3rHabPKnYWJghk9RrMTrw
         2AOQu7JaWJYXIJA6laBsmCZPigUGLOZMr2ceCjjpSaaBwTgURk8Zmg8UoteshZ7e2kEo
         XWqg==
X-Forwarded-Encrypted: i=1; AKwUvBzh4IXX/9/VE3k1z7d7mwYkkOfHyJ5jxtjLJHAmBaoz13vULAni7+m/r7qzAtD4+hEPdQYM3hs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIycWzZvZsdAOMhtDxEw946Ff214db31Ydu6fmYx0zXlLVJyjd9
	wVP6dtzAJghLHXUMEQP5w+ECWbXwfBKc1aTRjpvzUCv7SCDDzZ6kbwS/
X-Gm-Gg: AYBFou2uqVbaOvtfN4XbCM+da1bIhFFTGf+cqvPC40bw1/oJp7hdHGCDda8tLAtYA00
	KDoYDh/+3ZtKeBWChVutFIz/fO7UgFPcSH9H5IUpUu9yhC0HcycYyvhqKf54b/oatb8w4hWGVuj
	sqDDexbjmgxKy7l5PXwk+zAn+N8U/uZM90fQM2eY1OM0hlML/2B+e9p+8cq3ek9ZLEizapbAPmF
	fifWB3u+nQNbusJ5wjXJblgYr2lXRtjp+aXRDpqlCBGx/Xzy0aQEy9h3VOLeAexl8s7BCojx6zy
	sx0NS375BZP4j57YsOjemeJLmzQzs7yedg1gV0xsudoK4Mr9WTwAWxgcdDX5WORKubejnjP1EV+
	66rmvtS85JjQqRgqmBlsEOcZd4/R/K0svGE+wJGu9HbWeBMZsK5ZKdH8C9keBORhM3f71NaN62i
	VMeuer+LFCo9zVYIQcqQbTS9wFWR+qzXeNdCy2x+kkUjaK7ar8uKihsS1nnij0M6dFKZykn10gW
	i6502w8fVs+atgdtszyA3N9SgV8oWnNvl8WdiPabuszmA1N84tGNt9Ur8jHpygbr9wymeJdtA5c
	gmFUs/adx1Fcw2SIU8SMRwI4e08DS3ygAwPWcmc5xl7zXnTrlm//hyPx0m0vLxq5XLW0LoAbi+Y
	65BP12BE8VVt7
X-Received: by 2002:a05:6102:3e85:b0:7c7:f976:ea9c with SMTP id ada2fe7eead31-7d072bc74fcmr439527137.13.1793315894465;
        Thu, 29 Oct 2026 16:18:14 -0700 (PDT)
Received: from [192.168.15.16] ([2804:1b3:a2c1:77a1:5cd:8fee:f3c:4da7])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992ee4e7453sm319509241.11.2026.10.29.16.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:18:13 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Zhenghang Xiao <kipreyyy@gmail.com>,
 Sanghyun Park <sanghyun.park.cnu@gmail.com>, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 4/5] nfc: st21nfca: validate pipe ids in
 st21nfca_hci_load_session()
Date: Thu, 29 Oct 2026 20:17:35 -0300
Message-ID: <179331585573.30322.2945646231359516234@gmail.com>
In-Reply-To: <179331585573.30322.4049957541187612575@gmail.com>
References: <179331585573.30322.4049957541187612575@gmail.com>
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

st21nfca_hci_load_session() gets the list of open pipes from the
controller and, for each pipe id in it, asks for the pipe information
and records it in hdev->pipes[].  The pipe id is a byte from the
controller and is used as an index into hdev->pipes[], which has
NFC_HCI_MAX_PIPES (128) entries, without any check.  For a pipe id of
128 or more that the controller reports as open on one of the known
gates, the gate id and the controller supplied host id are written past
the end of the array, over the rest of struct nfc_hci_dev (including
the async_cb function pointer) and, for larger ids, past the end of the
object.

The pipe information response is not length checked either, so a
short response is read past its end.

Skip pipe ids that do not fit in hdev->pipes[] and responses that are
shorter than struct st21nfca_pipe_info.

This was pointed out as a pre-existing issue by the sashiko review of an
nfc_hci_create_pipe() fix.

Link: https://lore.kernel.org/all/178952042575.22033.9676833200303972344@kernel.org/
Fixes: 2130fb97fecf ("NFC: st21nfca: Adding support for secure element")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Yaga Agent HackerSec Claude:claude-opus-5-5
---
 drivers/nfc/st21nfca/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nfc/st21nfca/core.c b/drivers/nfc/st21nfca/core.c
index b5c1ca3ac..88856c26c 100644
--- a/drivers/nfc/st21nfca/core.c
+++ b/drivers/nfc/st21nfca/core.c
@@ -147,12 +147,20 @@ static int st21nfca_hci_load_session(struct nfc_hci_dev *hdev)
 	/* Complete the existing gate_pipe table */
 	for (i = 0; i < skb_pipe_list->len; i++) {
 		pipe_info[2] = skb_pipe_list->data[i];
+		if (pipe_info[2] >= NFC_HCI_MAX_PIPES)
+			continue;
+
 		r = nfc_hci_send_cmd(hdev, ST21NFCA_DEVICE_MGNT_GATE,
 					ST21NFCA_DM_GETINFO, pipe_info,
 					sizeof(pipe_info), &skb_pipe_info);
 		if (r)
 			continue;
 
+		if (skb_pipe_info->len < sizeof(*info)) {
+			kfree_skb(skb_pipe_info);
+			continue;
+		}
+
 		/*
 		 * Match pipe ID and gate ID
 		 * Output format from ST21NFC_DM_GETINFO is:
-- 
2.43.0

