Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EED3D88E3
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786708598; cv=none; b=Wx2P8YJRM/FinEWtw5m2I3peuu85r5/ioQv8e3A77vCCVcElZR0VQH1t4vo+UBr6USWOdvGUq8c2IxAGBbM1PaGD0CtVn4PLXzu2C3fjK5RhfujoC8rvqVLBfrwQuMtP2m3TpBa98TcCCJmDL2k26RrbjawhJ23HjHQlJP9e4dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786708598; c=relaxed/simple;
	bh=zrCQV8g4BsbbYSD2zfuevsQMa66d9LMXeb6HvD0DvyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NrfE7oAuzJiRkN/9LAXNF4mdBenGshJ7yhiH2Ve2MvyQJdJQwgnlOL9pZ3WHNllt1X2HRfZxi6jSFVc0cXMXMLafWJ2sgzc+NR7IG/M66/QOhSDc0wbKHWdb6zI76zX8kQY78GknvLQM20uiOxn2PqJiwZcQ9S0EbKw57AmYa8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZ8Azt9x; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZ8Azt9x"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso617879b3a.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 04:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786708596; x=1787313396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zrCQV8g4BsbbYSD2zfuevsQMa66d9LMXeb6HvD0DvyA=;
        b=aZ8Azt9xgJWTsyBCwf8wtIdNlz9N8bCTzOHqabPya9kRe39gCqyd2xPM0BIdAUxtoA
         BHutru/Rj+jVDgDiaP2TxjvvSPiE4tR2RBJ0OnzIrtksC4P5x0r8iI/sMDfAUkt07dlt
         ueOv7QEFt9K6byU0zbFOVmx3LfoBibGs13oi5JYAGXq+IvK5iV+xA5OIGfLLvd/xYB4W
         +WZ0Lc9TlfCxRIikm1D1OIvPtDSKOfMQ9NteIZbbV9HbdWRS0mvxkTD8G+CKVxryky10
         yM7zadSsNwz9DMMr1Kxd0WyM7NfcjcCaysLSkLhjKQ4ry9K2t0LZPEqdRAJhERCP6vXD
         Bm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786708596; x=1787313396;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zrCQV8g4BsbbYSD2zfuevsQMa66d9LMXeb6HvD0DvyA=;
        b=V1y38WxNska/bmEDfqk9nKIBl/dA8KvBymGYMqxSzp8XOKsvvfSMffZ0aDVddKPyHD
         4laJ7r3GE+nwFdEZVCCwzPCNylCdyzAHpVOxNz2lZZ6FiYOFB6RuPRwgtad8T+2D3rcU
         ZFi9ozunR1+MYt8tCyiq219y30NytWAdqPVAQ4Np4ePbMUL58+H7euSWj6ZTCH8iCfWd
         nOSGgnuQ7bGBOU1sbiHQeaRuWoSv3utKhsUjXgq0+Zm3EbC+24HlTXJQVUsBvo0P3KgZ
         9BHojXosXIZPfgW5xQln4rSLnVbO4P1Sr3vx1RMxIOORcsmtDPJDpxM4P24JHpL+3IJO
         +y3w==
X-Forwarded-Encrypted: i=1; AHgh+RrDtE/QHvS3QbjBz5cwaYo97un6gaZl9mDWMbIQGthnLAZ5mV6dxYjbGR6qxXDNycrZVHqekCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw53Po7s93DvU1v0XlLJqWPLO1L3us/wpVv+txxUFdnMsBOcxQd
	MpcJY1fvfIBqQOhHBgu/4wYtKMIhOIh9hPXOHd0co9UcMj7CdWfeKZlG
X-Gm-Gg: AR+sD13IYYkcpmKzZ6tqdsQQYVHmShZCVbOiVPh7kmQcQh6SdFYf/oB7IrVUjOKqqCk
	k0Lms1uLgpJHwnAVjrf21jkrNZ/G6w3X7W+KhHakllM2Xvm24LzeyYuzwuxKzNfnxmGQJhejQoc
	WV6w50XYl53VtGWm9aRJ8NHQtC+DCY/7is5pmvzgmPXhT6T9U6GrBxogONMhWchnrhSzgk/tJq/
	2yPmEQABRpu0b5MLsPlRlTugCLlDcDM/HYQ4Ej+fhI8GwKONoFO1pcCcTBCdnPCrHa69EvzsJvj
	ki/HknC/wRSEfn2Nq8ABT/LMNlJ1xtz3gSzaIk1J+CfbgEWxp6rvERI+CCbEV/tCE5jIHFXuZMC
	ZcwSTyfZfPLME4xW6I74QPb5sz/oIeQDEwvi9Cdfn08fUWXwwhzYbAWPhi3YAdTUxRAx6UvaWLy
	SMOre+FKEHwcQOM3Kuhb+EafDz5FLVQuvK10nhv9fBNBQnWVnNI3ZMq+M3WWt/
X-Received: by 2002:a05:6a00:88c:b0:845:e8f3:bdd0 with SMTP id d2e1a72fcca58-84fde2b6841mr5495706b3a.33.1786708595434;
        Fri, 14 Aug 2026 04:56:35 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517cfeb3d9sm366669b3a.11.2026.08.14.04.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 04:56:35 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: sgarzare@redhat.com
Cc: Jia Jia <physicalmtea@gmail.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] vhost/vsock: fix device IOTLB feature lifecycle
Date: Fri, 14 Aug 2026 19:56:11 +0800
Message-Id: <20260814115612.127842-1-physicalmtea@gmail.com>
In-Reply-To: <an7JAlFpRVOiC4WQ@sgarzare-redhat>
References: <20260814072903.124991-1-physicalmtea@gmail.com> <an7JAlFpRVOiC4WQ@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> In the v3 you mentioned that this could be used also in vhost-net and
> maybe vhost-scsi. Would it be better to include the other patches in
> this series as well, since we're basically fixing the same issues, or
> have they already been merged?

I did not explain this clearly before. vhost-scsi itself does not
negotiate VIRTIO_F_ACCESS_PLATFORM; the fix I referred to addressed a
different issue. See:

20260726144314.1652934-1-physicalmtea@gmail.com

The issue addressed by this series also led me to find corresponding
problems in vhost-net and vhost-vsock. It now appears that these are the
relevant backends here, so I will include the vhost-net changes in this
series as well.

Thanks,
Jia
