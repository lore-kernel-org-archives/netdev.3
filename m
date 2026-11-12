Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480835;
	b=2UAEnYA28aPSI2XA8ojFLGdXnPlKjKPJyBUsu7VJETozGdpHvBgRGL34fQ+xGJHl3Ieh
	 ZuCJv4Nq1iKOzooZSXInsDqj21KrTFluNJGmZFVu9FcccLvIC4WuPFIXPT8t1FLVjDN+S
	 JFn1xflImMuhHB/8Hp5xG2jojZQRCoyhBFXMTL/dcoWmj1ndOhvWoHMzYn2ZV5Fr9XyyO
	 Eih68mUCJ4QShzWSMFPQfitl6x+jzfl+a67DgdNxh08yUVH2kMdb3bi4WbDoVXSi/SV7U
	 eUZYIn4y8ztBsvpRcXFEelmhdDCdktFSVEnfpvS5peAO+sth+OqClMyBHkABzBeCidQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480835;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:X-Mailer:X-Mutt-Fcc;
	bh=x9FymSRgKEmF3YLVaEmXV+qBe5FB2zMq7gJot0C8RFA=;
	b=kJSd6dt58uKXtZf3QDm030PGeMe1tTC4UxzNT44Hbt3Hq82qA1blcwjysu/fNJzw5LdI
	 0L1N2PT9FwlXGL3iYZBjSgk1XPF3MdLA1pYLefS10FgzW1gJHNfG+0zqm6tlOH7/p1hCG
	 4YGXkQcze6XPnGdKYfRFMiXatSUKswViixozvJJfiflC1hAsqPSf+eCtJ4BdpigWDZLvG
	 sQy4pXuPdW7HBEp0z1fXMV2O5Z5rtldIiT7bf9crLLm/VnLG1ekjFr9Hx8BxALaWTJpsa
	 UOdHQPc8qUNeOi716tfdzokje100VQDbgUnCfFCFg8famq8OxOiB8zg8oGVeUcht4QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gbIsmZyd;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kYxzWQLj;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D29E606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D29E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gbIsmZyd;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kYxzWQLj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794480834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=x9FymSRgKEmF3YLVaEmXV+qBe5FB2zMq7gJot0C8RFA=;
	b=gbIsmZyd951GkYAeuc5ZVvZPM6iBmnW+NSEqvDeWCvQAXHsX3ABjnR0P4lGihKq90YfK6Q
	muIHNQdA/M0Q1Y76+xl/OBmt0j83U64zG185sJiLibkqkTSIltYKflwrqnOukKVyKoCKs/
	u1a6BAw5KImAlk18fDj78C4Fx2PVzbU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-jWEj8hRFNTupQT-WxUgwCw-1; Thu, 12 Nov 2026 05:53:52 -0500
X-MC-Unique: jWEj8hRFNTupQT-WxUgwCw-1
X-Mimecast-MFC-AGG-ID: jWEj8hRFNTupQT-WxUgwCw_1794480831
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-492d47f142cso537871f8f.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 02:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794480831; x=1795085631; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x9FymSRgKEmF3YLVaEmXV+qBe5FB2zMq7gJot0C8RFA=;
        b=kYxzWQLjAgb7uaSd94J0/GnE3e+uslJh0T7nLI6J5Y2CPFK/vi8ve70V/KvrFhlfXb
         2wV37QFKMOalUGJOTR9LzckAGvWSY7r/9RLfD/ATIjyHIUQFfjaU4/QzASTHohMie+L2
         3JdblAlJUCqEAT9YOF+ROtjzjTpVkvTIRndO2HpUNCaV29bS0yw1R+vbbW1aSgU+pcco
         xkboxj70uy73V4m802XAfLuy1zMD4g3P4ktC2GK9pgPGXZM4Y+DJ4vqpTtLiDak85cCl
         j11asEvqARn4jN0bKjaFP20rZ4PCbWURM7+xQXgbCPhzVRf4LcCZ1QFPC1ropbmu3nmr
         7Atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794480831; x=1795085631;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x9FymSRgKEmF3YLVaEmXV+qBe5FB2zMq7gJot0C8RFA=;
        b=p4SjlAGdKkAuy6WYdTZM9oZ5Yr2xRpRZb11EqscsL34OpctYNp5H/WofFeqGA3QR/6
         osHS1T0kffgXPTlwTOvKT8vvi+9VcxfnHyND8/Q7r8KBKEyqK/b8h5J4mzfeVOugq3FJ
         eclc+Wh1N7PXov6JX5NrU9xKWYL/0SfT2x3PqPMr3/7ILu/+O1yNnztYOZ+XG7FqqEa7
         mgjPptOfG5t6YHkj1Da1S1lhNChceQPWSG6JA/bvc2Rx5k19g2zfig3G1efYedaLnd5w
         T0+durffZRTVuo0lizkKi8He++LY61EGUwRJ0mwdaJzO/aU9WAjagR4mc+jEwji5W2EV
         L1ew==
X-Forwarded-Encrypted: i=1; AL+hErEChyZL1J917i1PIU4LPRAXUjVQVTXnOAp8kpdz5mpzcgEvjZSevC5h0zQRazVBjdaM1+e0Npg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/M9bVyjxr2vRtOOpgLw9cXucYp53VQxEX3KCeVA/HEWR5rkaIA
	iVBKUs8OTfkkXbpFknUaWohoYdSccUdj8Fzh2Fpag9qFg1OePfCAwBwUtKMwDtBxjcvsk8cuxyo
	pZtUjcFc7M3EEKgIIk7EJA0HFpN75JDCYLQllNt67+c2oynahv9OP+mgTrQ==
X-Gm-Gg: AYBFou1hPscADPt74lPBrXNZ/eoO6pK5JfWYFAcH8cJX7ANGAsjgfl+6HQPbfyVSNX4
	L+3bPEQNvUHo0vVcc+Src6YYzONM19PsuuLouqpToK/f1HqYx6RXLxWNdvEiVdwzWPvgBZG1Kzc
	OMfVHjs7WiztWe38krbrSqyS+36h58WWxx1l4YTUB/dpXQ1nzCP/K1ArzO+h0XQpBHXWcO6GMkT
	FgcNGhjEoBs0427fsXGGMIodHAPalB2ltTWpx6uAZ64PSMwPvGfawgDIAUTdV5Fw/jqThFdYfx0
	xqZgIjyF5Fanfa6CF3KJ/oKBiGKtTaPSQm7Xsjv2xA4+auL5sQJmUwhFPr544aXLvbvtpD48Xup
	PKKtHYRsG3g/0grYY/n7awkDtcQTCnTzjsu/LLH9n8g==
X-Received: by 2002:a05:6000:4211:b0:498:364d:7509 with SMTP id ffacd0b85a97d-49b02d4cd48mr4648423f8f.24.1794480831209;
        Thu, 12 Nov 2026 02:53:51 -0800 (PST)
X-Received: by 2002:a05:6000:4211:b0:498:364d:7509 with SMTP id ffacd0b85a97d-49b02d4cd48mr4648361f8f.24.1794480830624;
        Thu, 12 Nov 2026 02:53:50 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498365cbeedsm15992928f8f.43.2026.11.12.02.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:53:49 -0800 (PST)
Date: Thu, 12 Nov 2026 05:53:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Khan Zhao <zhaoguohan@kylinos.cn>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH RFC] vhost: set dirty log bits without pinning pages on x86
Message-ID: <af7f05bf637337d35fdd10f3e0dbb5e39d7780e7.1794480795.git.mst@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent

vhost had a TODO to replace page pinning with a version
of set_bit that works on userspace memory, since forever.

It is really best to avoid GUP on fast path entirely.
Implement set_user_bit and use it in vhost, to do just that.

Should not be too hard for non-x86 too.

Reported-by: Khan Zhao <zhaoguohan@kylinos.cn>
Link: https://lore.kernel.org/all/20261112085631.128819-1-zhaoguohan@kylinos.cn/
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---


lightly tested. pls test and resubmit with your tool.

 arch/x86/include/asm/uaccess.h | 18 ++++++++++++++++++
 drivers/vhost/vhost.c          |  7 +++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a0dd3c2b233e..ba1e7c3f83c8e 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -594,6 +594,24 @@ _label:									\
 	__ret;								\
 							})
 
+/* set_bit() on a byte of user memory; returns -EFAULT on fault. */
+#define set_bit_user(nr, addr)					\
+({									\
+	int __err = 0;							\
+	__uaccess_begin();						\
+	asm volatile("\n"						\
+		     "1: " LOCK_PREFIX "orb %[mask], %[ptr]\n"		\
+		     "2:\n"						\
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
+					   %[errout])			\
+		     : [errout] "=r" (__err),				\
+		       [ptr] "+m" (*(u8 __user *)(addr))		\
+		     : [mask] "q" ((unsigned char)BIT(nr))		\
+		     : "memory", "cc");				\
+	__uaccess_end();						\
+	__err ? -EFAULT : 0;						\
+})
+
 /*
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 2f2c45d208832..9ba16cbd788cc 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2405,6 +2405,12 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_ioctl);
 
+#ifdef CONFIG_X86
+static int set_bit_to_user(int nr, void __user *addr)
+{
+	return set_bit_user(nr, addr);
+}
+#else
 /* TODO: This is really inefficient.  We need something like get_user()
  * (instruction directly accesses the data, with an exception table entry
  * returning -EFAULT). See Documentation/arch/x86/exception-tables.rst.
@@ -2427,6 +2433,7 @@ static int set_bit_to_user(int nr, void __user *addr)
 	unpin_user_pages_dirty_lock(&page, 1, true);
 	return 0;
 }
+#endif /* CONFIG_X86 */
 
 static int log_write(void __user *log_base,
 		     u64 write_address, u64 write_length)
-- 
MST

