Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63376369D5D
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786188312; cv=none; b=A9ROgqBaE+sz0LZd0CnFTSitzjCSD2gk+nyAvInyr/6+QXIdRswNdZ7aEQl8eQLqCD1MUsx3B8pBt2gbyvyYs6GzopQbvKIlZg1Rjo3ccYPCbXzcv70m8Tcg8cmBDh5jb4L3dHjyq1ObLXNcm7ytY67jUVRA/AVvdW3G9NRLt0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786188312; c=relaxed/simple;
	bh=S06gw4GaTWEIrO/scYSHRfENLicYT3okDY8QqVj7Uok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WdxaNq9XsYrr0wqV7xt3EMbuwdr7sXEOWgFyE0s5rM7fRcMvssmL4zyuzuf4dL58nIAdBjoEEY/RPXRRqQT+kzZ6k7cHzAevfs8nOqSRiWG9C3/fpc6VB49sI++3m+07i/qJEG8PRIQYE8m/ovpMSSYSfxOFzTEWl5xZkwB6Xjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtqnjQya; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtqnjQya"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so259701a12.2
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 04:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786188311; x=1786793111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1TJD+ZNU8p0QF/zIOcyyYdEmIZzKa2aJynIM7jFFyUQ=;
        b=dtqnjQyalO/IWF2SeSYvrwd89YeBlK75DMQjFDjs+J2gmCeXbX5xr2rg86TD43iMzr
         km6I9I4Pd68ojPU72rttKGH/Glun7B8DxXDsTjh7pcRlBUzE7MHFS2h0k7m3BKkRIcwl
         8MhBQBXFoBHw42vRSGKlx0qE1dWx7KX8+a0NtUiaf7Q2qnfq4jgD/r2PxDnds8oTuO3v
         VWuU53GxKU7HUiUz15M1pSmvyIzy/AaX8ruhk0ZaQCLecHA0gsqJUF25pros+13O75t4
         ggLFzWfFPsley2ULRYDNesAb2rK3HQv6d4OXM8a/7Vh3bUfU+oPZCxJxUHlhRKsRonb7
         hpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786188311; x=1786793111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1TJD+ZNU8p0QF/zIOcyyYdEmIZzKa2aJynIM7jFFyUQ=;
        b=AoDOGKuKPXcMLSAEDpApxo9IeEpZyIj+0iVZrexQ5cB2kftk/Dkw9GTU+Xr3lGq9jq
         6BrvW9w6LnsDLhMMGeiSxkELnFgEW1Sk0Sz/CYzw/fvOc40KoBuZ1L8m20h8ogwDABMW
         jBPiakzq7XXnw70FDzqR6LU+zIybyOZMtzvKLByjvbU7oJcfijeM5Jt5jW6rBbbpyCmf
         /2O8FgV2ZQzz4ZYxLsFWFrUdLYh9mOaU0e/LfSWGrFngbyUy1l47nFQLjmg7q/RnXv81
         5KcQq1mR7QUZbCsKTWD4aYqulkONjVAmDI8DFvfFZdTBHGSg+k9U9RmHsaFcmZ4MzWBN
         FUAw==
X-Forwarded-Encrypted: i=1; AHgh+RqMSKwCkqfH229JvD0Du69wOwUkSPK1h4uQ0PpPAwomMv/s9ZKtxwBGhDtXHd9TgVR58pi21Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTefITgRBkAGVkZsgVOPGYTQRge6YXPA+2AsfXKQPPDgnnS70H
	p++XymfztC/+HQckyoVr+GV+27nkbGTcJ0unTrUVmTGCpjiB5vJ0FQSN
X-Gm-Gg: AR+sD11bxm+bYoWAKXMlLGLLROnz6IFPiw0IV1R7AzmIch8JLNrRx4R3UD21BRZ+aaB
	q6t2KeYPyCmsnMysuNwB6rDKbW6zVV0BMXMUMC1dGNaSJt8UWzKSuYmxPvSEOQGeI14RSZSaoL7
	AJ/mPL9fI4CJ2FhGw1MtYEY3FNCGTUesIS0Bs7+VApeOfbJroyCCsXiq8U7a0fLIWzLbA1J9RRE
	19zjX6X99YANkc0TCCB0lZYVH6DVJ3p7Ly7R04fKF77tWRF7onDjUUg+xLLLeMDeGhA8ZY/g4o8
	i+/ln3P4lVHFW59JhyYYi570kVJKTxHK9fZeNwCPZHgf2eQD5f5vj8BglrfZev0YieuDCmlq9V0
	ikfX9gOxxKTU/gQ3hdbp2jra+EQwf39hJhJuyDCSVz6x9y59/FDpNpD5rYFwGTTn6ovdgwTmYpl
	b9cVb+JdHRFP2eA5uf8QOvj9zZl3h1PeHjjqBmsavzj1w+yxjSa6pWz/nfBKh1I0Uh+cNOGC0=
X-Received: by 2002:a05:6300:4045:b0:3bf:83f3:b810 with SMTP id adf61e73a8af0-3cb85ef7f63mr36662806637.29.1786188310005;
        Sat, 08 Aug 2026 04:25:10 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebee8d0sm17746334eec.24.2026.08.08.04.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 04:25:09 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Tiwei Bie <tiwei.bie@intel.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] vhost/vdpa: reject VRING_NUM larger than device max
Date: Sat,  8 Aug 2026 19:24:58 +0800
Message-Id: <20260808112458.101616-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vring_set_num() only requires a non-zero power-of-two that fits
in 16 bits. vhost-vdpa then hands that value to the backend through
set_vq_num() without comparing it to get_vq_num_max().

A local process with access to /dev/vhost-vdpa-* can therefore set a
queue size larger than the device advertises. On the vdpa_sim backend,
the worker then walks descriptors beyond the mapped descriptor ring.
KASAN reports a 16-byte out-of-bounds read, corresponding to one
vring_desc, in the vringh IOTLB path:

  BUG: KASAN: out-of-bounds in _copy_from_iter
  Read of size 16
  copy_from_iotlb
  copydesc_iotlb
  vringh_getdesc_iotlb
  vdpasim_net_work

Check the requested size against get_vq_num_max() in
vhost_vdpa_vring_ioctl() before calling vhost_vring_ioctl(), and return
-EINVAL when the request is too large.

Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
v2:
- Add the missing Signed-off-by tag.

 drivers/vhost/vdpa.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ac55275fa0d0..b2083e1ef150 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -716,6 +716,13 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 				vhost_vdpa_unsetup_vq_irq(v, idx);
 		}
 		break;
+	case VHOST_SET_VRING_NUM:
+		/* Reject sizes above the max reported by the device. */
+		if (copy_from_user(&s, argp, sizeof(s)))
+			return -EFAULT;
+		if (s.num > ops->get_vq_num_max(vdpa))
+			return -EINVAL;
+		break;
 	}
 
 	r = vhost_vring_ioctl(&v->vdev, cmd, argp);
-- 
2.34.1
