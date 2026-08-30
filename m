Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA07854763;
	Sun, 30 Aug 2026 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788099930; cv=none; b=cXtbyVNC6Z9Qi2JO/Gf6fPGi2ex5fmF9u9gcZBiXtHp70n1sq7oLQ+FR8nIzujf3D5p5CzA3Q4Rg1TkkTsiQBHqVZuedAbdoPQ3ULVSzqfKT/h+vFVOIoIyx0d6XRO2l2Fb70iyxmwTDl3xGXjNQExuYZtvlUQ6u3mZOAE+KnxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788099930; c=relaxed/simple;
	bh=HgaAyLZ07e4+mMArdnysZ2xRFD/5HdhMbxc4l4x8G/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ox19CQPixXACl/0FbzHDOoDOgUOpVTIvfl5OMZV9Nur9O7qNHW+W1sVdwcZfN05KEyCEAmN90xpY/xTIqD8CgwVlBF0zEszM8y0Io7mGqqbGRuYXb0MDOVQFcoH51urLe7ukegZz9ddywt8s+yl56uBVBCbOiGpDeEEl7jRsOPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-03 (Coremail) with SMTP id rQCowADX4D5MPZRqIbybBg--.18339S2;
	Sun, 30 Aug 2026 22:25:16 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Alexander Duyck <alexanderduyck@fb.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: fbnic: validate mailbox TLV extents
Date: Sun, 30 Aug 2026 22:24:58 +0800
Message-ID: <20260830142516.38145-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADX4D5MPZRqIbybBg--.18339S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFy3CFWDury7tr4xArW8Zwb_yoW5trW5pF
	yUWa4Iva1rXw17Zan7Aw48u3Z0ka1a9FyUWFyrA34rZFnrZFy2k345KFWIqF45tr48Cry7
	Kr4ay3y3JF4DZrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r
	4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjfU5dgADUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The mailbox path warns when a message claims more bytes than the descriptor
but still parses it. The attribute walkers also validate a child TLV before
proving that its declared span fits in the parent remainder.

Reject invalid mailbox message extents and bound each child attribute
before type-specific validation.

Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c  |  9 ++++++---
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c | 15 ++++++++++-----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 283d25fae79e7..ff1674eff7ad5 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -1677,16 +1677,19 @@ static void fbnic_mbx_process_rx_msgs(struct fbnic_dev *fbd)
 		if (!length)
 			goto next_page;
 
-		/* Report descriptors with length greater than page size */
-		if (length > PAGE_SIZE) {
+		/* Report descriptors with invalid message extents. */
+		if (length < sizeof(msg->hdr) || length > PAGE_SIZE) {
 			dev_warn(fbd->dev,
 				 "Invalid mailbox descriptor length: %lld\n",
 				 length);
 			goto next_page;
 		}
 
-		if (le16_to_cpu(msg->hdr.len) * sizeof(u32) > length)
+		if (!le16_to_cpu(msg->hdr.len) ||
+		    le16_to_cpu(msg->hdr.len) * sizeof(u32) > length) {
 			dev_warn(fbd->dev, "Mailbox message length mismatch\n");
+			goto next_page;
+		}
 
 		/* If parsing fails dump contents of message to dmesg */
 		err = fbnic_tlv_msg_parse(fbd, msg, fbnic_fw_tlv_parser);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
index c55d4f76a5fc0..639f90664d982 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
@@ -427,9 +427,12 @@ int fbnic_tlv_attr_parse_array(struct fbnic_tlv_msg *attr, int len,
 	/* Work through list of attributes, parsing them as necessary */
 	while (len > 0) {
 		u16 attr_id = attr->hdr.type;
-		u16 attr_len;
+		u16 attr_len = FBNIC_TLV_MSG_SIZE(le16_to_cpu(attr->hdr.len));
 		int err;
 
+		if (!attr_len || attr_len > len)
+			return -EINVAL;
+
 		if (tlv_attr_id != attr_id)
 			return -EINVAL;
 
@@ -443,7 +446,6 @@ int fbnic_tlv_attr_parse_array(struct fbnic_tlv_msg *attr, int len,
 
 		results[i++] = attr;
 
-		attr_len = FBNIC_TLV_MSG_SIZE(le16_to_cpu(attr->hdr.len));
 		len -= attr_len;
 		attr += attr_len;
 	}
@@ -476,11 +478,15 @@ int fbnic_tlv_attr_parse(struct fbnic_tlv_msg *attr, int len,
 
 	/* Work through list of attributes, parsing them as necessary */
 	while (len > 0) {
-		int err = fbnic_tlv_attr_validate(attr, tlv_index);
 		u16 attr_id = attr->hdr.type;
-		u16 attr_len;
+		u16 attr_len = FBNIC_TLV_MSG_SIZE(le16_to_cpu(attr->hdr.len));
+		int err;
+
+		if (!attr_len || attr_len > len)
+			return -EINVAL;
 
 		/* Stop parsing on full error */
+		err = fbnic_tlv_attr_validate(attr, tlv_index);
 		if (err < 0)
 			return err;
 
@@ -493,7 +499,6 @@ int fbnic_tlv_attr_parse(struct fbnic_tlv_msg *attr, int len,
 			results[attr_id] = attr;
 		}
 
-		attr_len = FBNIC_TLV_MSG_SIZE(le16_to_cpu(attr->hdr.len));
 		len -= attr_len;
 		attr += attr_len;
 	}

base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
-- 
2.50.1

