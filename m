Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793328017;
	b=WChfI8YJs/HrvHCx34Xm0YezFMp1mXc1nRExVLLYQd0ixyb/Rox91OHhnrsnwJOGFNAt
	 gLW0TFJ+GFFIUOvBA7jxYeI6kFUOIcJwZJtJHp5VZDsLcvhhAKAMqOmHR3ZqUBarL/3gc
	 wj0Zkxi7eCQ06+BaMq+YatSSIgc74ZA60anPsf+veot37Lfxi0xiC1kwez1U76VTGE2qZ
	 hvXnPVjzrjh0cgbmRpa9HkAYoC8o56WFRnsSybHPffRqCD6bB91dGUeJ3Nnyg4bLFEUAb
	 A1Qr0DmwrBJiW0oDyt5ipymc3VP9QYRyb7+g6DEwmvWynpHAz5z2++x6pnW60lI6Apw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793328017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+ELhbW/6uxFSOtLiXrpEjFCc5Al5bqntgfPHZO1Nwwg=;
	b=YaGh14W3Bcr5/LuYhabIle8CQOm+nYnRgTVLRtiYwvcVeWQX0ekhYWyVovc5TXXt1mqv
	 1yGTZFRRErMqQcsc8HLsNbrx5UN6aQdY9zrP1xW75CCBWrR+r9ir21le6hjSI5OJ43Qbv
	 YtJ4SJYA1BMbl35tYAR/wkTz1M9zy8Jdh3wfDIQmfUws5zsAVlWMM4qLZz2XagwT3hxYE
	 kqD5t6jLt0kA26U4nbIkq/oAjlQ+ryGBVjHsDHd+PpI5ZTji3Iuet+Ct9pZVTT+UjCMtW
	 pmcvcm/snh0PeSduh9QFiC4m6sCAPY1rsRMWpBGZlzHz+FQwRDYeqOycS7EopUfEkOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vAisCruQ;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A048606A31F
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 02:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A048606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vAisCruQ
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5ec20398b05so276384e0c.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 19:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793328016; x=1793932816; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ELhbW/6uxFSOtLiXrpEjFCc5Al5bqntgfPHZO1Nwwg=;
        b=vAisCruQ8cBFET8/dNwfmyX4n77Anbj6EdSlbqajFzCnS4ibrEtl1nvb9B4yOA8Pgb
         y6qBY5tyTutbrINbP9qrKQnGBuoysT5emmza9W8WrZRuTbWGaEuNoEq1LfXZe+zl2omN
         oz1xP+KvELhetEI+CFCf/RSa2SHk35YqiIwHoWJF4HMVzh/fBjcwc4hBs8KoDLld8Efv
         kEh7pG9RvwS2tst/SqVyjwRq92JVGJQqGzfJ3aGUDY32N+hkW9LEqdupYbtyT67gc5fo
         Z2JWMIkV9aK90ZiO7ouT4iWD1AnLaIMzsaeGPoqLzug9mHJkSWq3xjliW0k+OO44zekS
         EGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793328016; x=1793932816;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+ELhbW/6uxFSOtLiXrpEjFCc5Al5bqntgfPHZO1Nwwg=;
        b=elv4kAEgSBy7tgLHqXf0tLuIBRAYCZKOyKxTtHXIHxNiMqemvFDvm5Dh8SGjuouBAv
         VM932ITu53udSNf+jKJYXaAekHNQB8uYdhoZKKLS8bgVyc16mmYlUKbc8HH2KJPr8Kzp
         2+w5RB9UsCjbnimAciy+ot9CnvYKbY1j+0MHsAPcvLzB4Jg7ciMDx1I8YaKtlC7oAUz7
         J69HPt5A0i2w0n3pnlOn2uqw1c5Djins9sHQCRIE5c8oA6mTUhavypqZjntsG2E2iqPu
         aW3Zyf79QnquTiMHDLMA11FGdaik/464y7n+ZU67MoxFd/JBibk240bcCbioVSKQvylZ
         rFvQ==
X-Forwarded-Encrypted: i=1; AKwUvBwKW+5Km4UJiBKdqDmaxRb0oJf2ngnZUss48n/X/zMxCwhJtqIwftaHNyvRyeW9EkJf66vMetc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9Pw+rJGP1LGnvJoivpQmcCvIcYz64g8OHDf6fae6LWJuH0eZL
	2Mt/rjbKYDlvRJGI7gNJ9hG0EIYp8SoG8Vavlk3u/hLtxrWgSb9xBGpz
X-Gm-Gg: AYBFou0O1BMwlwyI0nuNeKoLimjQf8u3ktm7S35EbApoc6k7AWvO0jZl12vCBT9JpHd
	KqBOmiuenaLlyXqjZHo/5jtcU4UkTg0TfEwy/vB+4QdKbCgwa1gMZgFlpAsPc37Vyk9tLpNaOXg
	vK4Rc96cPXQ9hIB06yVSUCHKfB84UisApPIZelmlVof2gbOqBluFGcL53uqxMx076D6ilVE4EWO
	eDm2GhpFUCa7/G48hV7q+5sGa/eaU+NjpftDMQllIPYELCFPCgw8qMl9CACWQsn3eQ1zBAcyMIb
	iKUGRPa2bY7IepEFBdcah4ojb62OkgFWht4RyLJ/eI1n4IqUgoNeU24W4nX8DvZ+j2WhWG3Rj8t
	vS+TeDnR/4JyRQ38I2WE6jHz/bRkO1+mQgSmoUWS+b93TJSAxG6HTTIoqdBis+HuULhOECg1ulT
	azfG4j0Rwz61s/4IhpWwruwd/eva6ngWssvat3a/24594c8oTcRRvEyzg4AYHSSEr0eivrHlvbQ
	az50FsdTVIkB9lvCNIxn4b0TMG+IDguoWdS6wOPkPj9mSVnLh76Wd56wBLTCvMIsrlNiP68V4Bu
	2tpcJGutEuro0pa5ivL770x+CJO9z2+zdWElQIw330qDhyNCacpOapwmxYMD2S0TH87txwqV7Fy
	Ncs6eLvNkX6SPpf3rR28VwkcekC7w
X-Received: by 2002:a05:6122:ec5:b0:5ea:dc36:245b with SMTP id 71dfb90a1353d-5ec6896de21mr562647e0c.18.1793328016018;
        Thu, 29 Oct 2026 19:40:16 -0700 (PDT)
Received: from macbook-pro-de-joas.local ([2804:7f0:b101:c5e8:ccdf:2b09:f69e:4902])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c5d183sm963735e0c.13.2026.10.29.19.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 19:40:15 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: David Heidelberg <david@ixit.cz>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] nfc: s3fwrn5: validate the firmware image size against
 the firmware file
Date: Thu, 29 Oct 2026 23:40:02 -0300
Message-ID: <179332800288.52644.4206885352837613064@gmail.com>
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

s3fwrn5_fw_download() hashes and flashes sector_size * image_sectors
bytes starting at fw->image.  sector_size comes from the GET_BOOTINFO
response of the controller's bootloader and image_sectors and the image
offset come from the firmware file, and none of them is checked against
the size of the file.  s3fwrn5_fw_update_sector() also always sends
16 * 256 bytes from the start of each sector.

The controller decides whether the update runs at all: it reports the
version that s3fwrn5_fw_check_version() compares against in
CORE_INIT_RSP.  So on every device up, as long as the firmware file is
installed, a controller that reports a
large sector_size makes sha1() and the update loop read far past the
end of the firmware buffer, and one that reports a small sector_size
gets up to 4 KiB past the end of the image sent to it in
UPDATE_SECTOR data packets.

Check that everything that is hashed and sent lies within the image,
reject a zero sector_size, reject an image offset past the end of the
file, and make sure the GET_BOOTINFO response is long enough before
copying the 10 bytes of boot information out of it.

Fixes: c04c674fadeb ("nfc: s3fwrn5: Add driver for Samsung S3FWRN5 NFC Chip")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Yaga Agent HackerSec Claude:claude-opus-5-5
---
Tested on arm64 QEMU with KASAN, with a test-only module that registers
s3fwrn5 through s3fwrn5_probe() on a virtual phy and a userspace
emulator for the NCI and bootloader protocols.  With a 4156 byte
firmware file (one 4096 byte sector) and the controller reporting an
older version:
- sector_size 0xffff: oops in sha1_ce_transform() from
  s3fwrn5_fw_download() without the patch, update refused with it;
- sector_size 16, 2 sectors: KASAN vmalloc-out-of-bounds in
  s3fwrn5_fw_prep_msg() while building an UPDATE_SECTOR data packet
  without the patch, update refused with it;
- sector_size 4096: the update runs the same with and without it.
Not tested on hardware.

 drivers/nfc/s3fwrn5/firmware.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/s3fwrn5/firmware.c b/drivers/nfc/s3fwrn5/firmware.c
index 9145deec7..159afb8de 100644
--- a/drivers/nfc/s3fwrn5/firmware.c
+++ b/drivers/nfc/s3fwrn5/firmware.c
@@ -93,7 +93,8 @@ static int s3fwrn5_fw_get_bootinfo(struct s3fwrn5_fw_info *fw_info,
 		return ret;
 
 	hdr = (struct s3fwrn5_fw_header *) rsp->data;
-	if (hdr->code != S3FWRN5_FW_RET_SUCCESS) {
+	if (hdr->code != S3FWRN5_FW_RET_SUCCESS ||
+	    rsp->len < S3FWRN5_FW_HDR_SIZE + 10) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -307,6 +308,10 @@ int s3fwrn5_fw_request_firmware(struct s3fwrn5_fw_info *fw_info)
 	memcpy(&fw->sig_size, fw->fw->data + 0x18, 4);
 
 	memcpy(&image_off, fw->fw->data + 0x1C, 4);
+	if (image_off > fw->fw->size) {
+		release_firmware(fw->fw);
+		return -EINVAL;
+	}
 	fw->image = fw->fw->data + image_off;
 	memcpy(&fw->image_sectors, fw->fw->data + 0x20, 4);
 
@@ -409,11 +414,26 @@ int s3fwrn5_fw_download(struct s3fwrn5_fw_info *fw_info)
 {
 	struct device *dev = &fw_info->ndev->nfc_dev->dev;
 	struct s3fwrn5_fw_image *fw = &fw_info->fw;
+	size_t image_avail = fw->fw->data + fw->fw->size -
+			     (const u8 *)fw->image;
+	u64 total = (u64)fw_info->sector_size * fw->image_sectors;
 	u8 hash_data[SHA1_DIGEST_SIZE];
 	u32 image_size, off;
 	int ret;
 
-	image_size = fw_info->sector_size * fw->image_sectors;
+	/* sector_size comes from the bootloader and image_sectors from the
+	 * firmware file.  The whole image is hashed, and
+	 * s3fwrn5_fw_update_sector() sends 16 * 256 bytes from the start of
+	 * each sector, so all of that must lie within the firmware image.
+	 */
+	if (!fw_info->sector_size || total > image_avail ||
+	    (fw->image_sectors &&
+	     total - fw_info->sector_size + 16 * 256 > image_avail)) {
+		dev_err(dev, "Invalid firmware image size\n");
+		return -EINVAL;
+	}
+
+	image_size = total;
 
 	/* Compute SHA of firmware data */
 	sha1(fw->image, image_size, hash_data);
-- 
2.43.0

