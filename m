Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589614;
	b=B/95g9KRbpTX/ikM9nmc1O6iAYe0DX/TQhXkTtzoBG8ZUqPDBTiy9M4mPf4gnrvb992P
	 M5YeqzlMIf7gcqMY0QDfn2Sd1AMPW3ZJniLT21DswTP3ws9u4cjdZsfnYZMafyJHfZu3d
	 4QfqBHUx2y0ZA6fizWVE8aCPI+YEp9O/r9w0TubBkBjjPL8r+59OhTEc04cF7InvwBdEW
	 ky565hKZ1Yd4cHfbQtQKHBeaHmN/tBySBEDTvQ+OHPAe7zWwyvSvbbMWx8FRM+do5F0Ah
	 VDKNqHO0YQG3seepadAQgikPx9inWXgf0k4UKVITGqYY0/E6bcoZ/p8NALIEW8pFceg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589614;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/Kki3X4dpm9KxQ2mH9Sq8u46jfClQkMQattSavxbdrg=;
	b=oICa0VlhPJZilo6v86WNwMmchVL3O8Sl4vcyV0oThm2NyNKefHPi0U8Kkx+3DrpTLr+S
	 WcmjyP+FRfLTin3W2NLGiozPh0eSPxPTNkLbRejTYp3QLn7NTImtXSk+as+ww64QCo4re
	 sYrRj//zuDdxpyIaWuMaoMTCh9ULoZTtzCG7ez+tj5boVCfLYRAckG31H5GbKrpyhfuyV
	 bsbkcsYFRvgC7epJmu6KhnHnqfY8yQHZFTrUtyyAFA8dVijKJ8mTFehQ1DNVx6wqhe1xk
	 1JOchOmVf7PlB5/oIWqXsVzImuhpffAAVRYMCITdvc7mzbD5iRG0WYSB8d6jKzE6xBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YTwIU9jp;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=DN0A8kzP;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EA7606A327
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 17:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12EA7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YTwIU9jp;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=DN0A8kzP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794589612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/Kki3X4dpm9KxQ2mH9Sq8u46jfClQkMQattSavxbdrg=;
	b=YTwIU9jp1H10/trgxoH529RJD//rDcGtE/KAHUwAzqP+nffumFcQFMYAHwZ0FDQQXW10US
	n6Ddv5SnAAQhK87ICTIY3r7JinhINqywi3mk2UwUdm+LYDmJSHFeOiuWSrhYMSUhvYOYEI
	DQE18t5VK5D9lcaFhulAmIpiIhXdNJ4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-oAlRiyWmNSySE87i5LMS3Q-1; Fri, 13 Nov 2026 12:06:50 -0500
X-MC-Unique: oAlRiyWmNSySE87i5LMS3Q-1
X-Mimecast-MFC-AGG-ID: oAlRiyWmNSySE87i5LMS3Q_1794589609
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4ae2756fa7aso6759415e9.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794589609; x=1795194409; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/Kki3X4dpm9KxQ2mH9Sq8u46jfClQkMQattSavxbdrg=;
        b=DN0A8kzP7RKo5fQGq5KIDkrbwb79NY3IE65mhKRVjpzPSTFMS9eMdYv6wgN7jB03k8
         S5OFWCcwkMw5tCtB16JOMgqvqLtXGNFC2gmc8g41p0IXmkraV2y7AcK3Q39pBERBptw6
         IWS40Bc1CIAH64kHFFyf+RGmHxuIJ0fhyAxUWfHmKevHbVfSUm4F6PNY8oAnX3S42pyp
         SUyXtLrVzeJSsN3MLTG9GmVNGNR3xgl2nw0Gm3n8mbAgJZVZapgbaQfXKj2fb2ZIkM3i
         J6/228HRBxCKwci4uHO4D2EJeBiJnknWP//bRZo/7Q623qGSFAYF1puHjnZTsRalv9ym
         ZErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589609; x=1795194409;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/Kki3X4dpm9KxQ2mH9Sq8u46jfClQkMQattSavxbdrg=;
        b=sFTkIJRmWCyAZZxCcJ0fxNG/5yKcDRtaOCDvzLLiRTg0htvpg5ANLGC7npIzXtB3ZN
         /hT7Ljvy5tuVhCO8Nqg4JXmuqHIgKcj9g4LtXqrvH6KR3rNTGzL0WqU+gpFhChZ66wRk
         gPTZO3ocJgaKrv1CI14hjRIFiJQqHfNE+0zHR5gf2Fs7KJGy373N+B85z+GhIVgBM+23
         S/kWgysgwUNvFKFnOKSi2FlC6D0ZurGRJ+xuvUFfEADHLMSIk79CBy4k/MU+6HGqnbNL
         c+Ol2Kk4cT01pYXUZPGzhDXMdccJviA2GjpqdCSoRDvydXVBT1im3+g+X7wko1ecNc+G
         UG9g==
X-Forwarded-Encrypted: i=1; AL+hErGA3zLKns4AxcIAPHipZKLPAc+Ar8kNMLakbD+37J2+FohrgSDTwfk2BkPlA5omvpJ5uVJh9ZI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9b5egKkpRH6Jo2Kn/uw5tiNb6Af2eNguPlwVIKVDBdm26fRpJL
	11IX2vClmyedIiBPvoRkwAAVgUBDOr7SebfsPQlgDz/E57Xt16n849E+5WWaT+QypAMeJ2I0wru
	jS2aERpLZu9xWvbi5RMrIdRyBtNBuGsHVnwYxNPR6vcr4CQ0oKN0w/AUQoMpjFW4R7I9j
X-Gm-Gg: AYBFou2LoEZUuWDDd1S93G295o1fIQKIpMSWhcrX0e9HKuND0boz/u/PE0Jz0cyMM52
	SkJM/zQmELVPs8bB2NtpI9s3ifeQdEbLhyPJ6rqWGXAHmB2o6B1VwTlnU1midal6gn5y4tIH86S
	mSsw6Wz6eUgDWvdmpm22EYm3mLY+xVOGS8/Mdu8x+w5/rP1BIB+wGEazb8w9bZW4QN38wwE11tr
	QHwLHnwem0TQLeG9hZpYrGLRZt1fE7OGzACMaF+BrtqAsr1N3CMg6VVVDLJSNKv3F8SdjdQnmeL
	hXkB1uneqkuZ1RGW6k4bssYJ8JArTVJFFIj5jhuUM99wd2myJEj+SsfzZLKIMXgQiDveWe9eCZh
	XI9zare5WoOFSATgl/HCWcJJc+AijsLnP4QUTBRZ6g0iqyoc9tlcb3yoZTyNUQiTvVCJbcyWDPz
	83RxHtJN+DRoo=
X-Received: by 2002:a05:600c:c84:b0:4a5:e6fd:65e5 with SMTP id 5b1f17b1804b1-4bb55aa3a2dmr71557455e9.31.1794589609286;
        Fri, 13 Nov 2026 09:06:49 -0800 (PST)
X-Received: by 2002:a05:600c:c84:b0:4a5:e6fd:65e5 with SMTP id 5b1f17b1804b1-4bb55aa3a2dmr71556725e9.31.1794589608889;
        Fri, 13 Nov 2026 09:06:48 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f7828a4sm6409906f8f.23.2026.11.13.09.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:06:47 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Fri, 13 Nov 2026 18:04:40 +0100
Subject: [PATCH] vsock/vmci: reject datagram binds in local network
 namespaces
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
Message-Id: <20261113-vsock-vmci-netns-isolation-v1-1-ced02054ea61@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBtIjYSuEi1CpxoqDSckiO6et
 HyL/x8QSkwCffVAoszCMRSougK3TmEhZF8MutGdUspglug2zIdjDHQFQZa4T1fJ0FLbWaO989Z
 AGZyJZr7/+TC+7we3RtBCbAAAAA==
X-Change-ID: 20261113-vsock-vmci-netns-isolation-7e46732dcd73
To: Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, stable@vger.kernel.org, 
 Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2143; i=slp@redhat.com;
 h=from:subject:message-id; bh=KbQnqpP7rtV1X6O9hhQI+C1Zj1a1cacc8D6sCunHM3M=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq90Ol4hWRYE7DbdCG5kDAinIgd4TLSotKXr8+l
 VPEwubE0OiJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCavdDpQAKCRD0aSeNLwwC
 NTBrEACV2PMED4/7MyILMjnxuQfgS6QtiXtgSOjXHHrW3NfewioLlE1yJq6GEI03bNZP+lqKNQR
 AccWn/H2lR3qiABFWlijCpj1bJ6X26crcqVK0PEnG0KLdQkz356ogEpbDZtka1wFJR8w2JDhbRh
 Ys3iF93SvftH8KvSXnk+4rtMnbeUgKgHuL36L9XydhATObsweqMwrKlFJsNMdNpfOAJcpnxaAYg
 OqRFXGGO7Os0d1wmnsJL1uW/b/rMPdDxqWa6DTa1fPo4y4eqlIeWBO7HN7/pkHF7/tyUN+1DH/3
 MQkWZwr+IHTEuF7W29ASzuHcYsauRC2kn9sOFhkT/sEIRAo2exPo7Z9R/WQujO5VG2ZyhvFeWMg
 ymJ2iO2YcbzSPwiuXvjCBEPbht32xQmpRGvFMC/Cc7ZLvKZ0h+62sIROMdWZdi+keTkFZfCLn7O
 hHs6bbahrRf96RF/J30sUH/2kZ5Jkq6gROnToNOk1HJK3bjL/CyMOoTohBR3sR0+uZOaH69RTRl
 8ZSXuy0vIkwZM68jjduCnqtEMeMi8JT2yvpqyV6cq/IXhBqvQ7Jw/1Ik9hioviwwfvY5KyGML9i
 tK5qfhNnseLN7nPGYt4cCJRlBOfE7RajO1maGZq0JO+9wSiQa49D/53RC5VP+bmBLvPGjbT7C05
 ixnW7xHwBAI1d5g==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

VMCI already rejects datagram sends from local network namespaces, but a
datagram bind still creates a receive handle in VMCI's global port space.
A VMCI sender outside the namespace can therefore deliver to the local
socket. Its handle also prevents a global-namespace socket from binding
the same port.

Reject VMCI datagram binds in local namespaces. No namespace-local
datagram transport exists, so EOPNOTSUPP reflects the available receive
paths. The receive callback also rejects any local-mode socket as a
defensive check.

In a KASAN/lockdep QEMU guest, a reproducer observed cross-namespace
delivery and the global port collision before the fix. After the fix,
local bind returns EOPNOTSUPP, the global bind succeeds, and a global
VMCI datagram still reaches the global socket.

Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/sashiko-outbox-212907@kernel.org/
Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 net/vmw_vsock/vmci_transport.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 1f186e8f8364..282131544c42 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -627,6 +627,8 @@ static int vmci_transport_recv_dgram_cb(void *data, struct vmci_datagram *dg)
 	 * outside of the create and destruct socket functions.
 	 */
 	vsk = vsock_sk(sk);
+	if (!vsock_net_mode_global(vsk))
+		return VMCI_ERROR_NO_ACCESS;
 	if (!vmci_transport_allow_dgram(vsk, dg->src.context))
 		return VMCI_ERROR_NO_ACCESS;
 
@@ -1697,6 +1699,10 @@ static int vmci_transport_dgram_bind(struct vsock_sock *vsk,
 	u32 flags;
 	int err;
 
+	/* VMCI handles are global and cannot serve local namespaces. */
+	if (!vsock_net_mode_global(vsk))
+		return -EOPNOTSUPP;
+
 	/* VMCI will select a resource ID for us if we provide
 	 * VMCI_INVALID_ID.
 	 */

---
base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
change-id: 20261113-vsock-vmci-netns-isolation-7e46732dcd73

Best regards,
-- 
Sergio Lopez <slp@redhat.com>

