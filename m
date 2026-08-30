Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1819D3BA22E
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788107091; cv=none; b=Nsd0b6pgghb6XThumcO7fzZWIJXibI4rzs0B0EgASobMHZG5Izm+JhT/rgYUc/5VVxOR6udsbKvomfpe69zzdkZIZBf/nYM91n6hwvDE1qoYN73pgQjtPSS8wjkIk2MMGRPhu/hE+OmcT5IEK12YwVjJ0QWqiQbqY4cmwKAYWPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788107091; c=relaxed/simple;
	bh=wd4/Np9BcKgCQVe8dzA/j4ReDI2xnURtUc5ruSckYZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rr4kqlASzlnRrliLIgBBB7Bop1bMVmMOjV6w2w3d7fIvw50kqrPzT4vEPNg7MT/pjqIfM6ItrNZUJ2ZyTCkb+TAktfhOCn0REkzbwffKSr9+4O0Bx8BMJgFRMD31Pa7lCYB4C+l5obJF1kieWJ3ib+W2gG4XoPaR3eWnpc9l6Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0zqLHRP; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0zqLHRP"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso2424549a91.3
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 09:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788107088; x=1788711888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9uoOcHIFQQdBWhdhIIcmPfZrkUN2MX77IqhljKCPDFs=;
        b=Q0zqLHRPkU/cKQ2pboJU+wNDp9U9QRIfbF1N+vrdYwdw09KvpxCxldeakOZakYUevd
         C2rQMt2P0f5PdDEnVqURuBGCqG2EN7+HCEIndGVUJ4V65XTpA1Ziys4DIC2VoLya4ULy
         lgTxMTJQropDd1f1F8G5oF7w4TFzwPgwPQfjGVIHH0OYNinUQc4ugARsLVqVOooS3P/3
         Ec4MJY/RF86dU2i3fmnP33P9+U5JehNQ+9lebyA8rU+gt4OBYvG8UPs1ErTcZZXJ0mR3
         3j5N5+Q4E4x7E0+Bq1bLopgZSQqW8X3yRcN3gPJ6FXZfYF8eGQjE50AIP2HiQTJtGLKF
         ty3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788107088; x=1788711888;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9uoOcHIFQQdBWhdhIIcmPfZrkUN2MX77IqhljKCPDFs=;
        b=f/BnUgzDloF4/5rdKHXgBN/lH6nUoM1MNYOnuuvAhFjM0I5Z7q6oZGRknmurd2ZAi9
         1b9EoOVkv4bvO45QswmZ69fLHYHZ2RRi7CVR7EcfqmzwQ76sxySc8kIR8afvsazxVFF6
         MWIoQwKY3uapCL9REmW14LwS1nJ/IHguKoFYNnf88OaSvskXfhMm9CkG6frESQZ6aVt5
         XbHkpQu7J4uauWQbpGwxWN4kkf09ecJjnfPaYl5YH9Yoa2Aex6AqAOCsfPVB4926fvb0
         s49J8PHgw7Trd1EfK9EzIa1MAArFqEdpA17C9MuDdSGIMCgBKHZyjDLvF0CcEjw390DZ
         ZYLQ==
X-Forwarded-Encrypted: i=1; AKwUvBw4n5XNwJRkYbLbxTRPQeLyjIA+WF/9kDRsG2U1sebvORxYdTy2XPnXsXrrGtYEFhmOjJTDuis=@vger.kernel.org
X-Gm-Message-State: AFuF++muEn2jgQfQAjcM+XloIpIXgFAz24bRswJ8hGpnk/dQ8v3sIJpf
	KeujYlnoP5hbLHRofFfJLaOY3yvX529t979w1eyq8bLNgJCH8RQ+am+b
X-Gm-Gg: AYBFou284sYJd3INc/c2imzHWInNnKwjgugsK900ZYnrrNQG9CbA8pLU/sxl5EbMYVL
	Jc3/OZ/XLDRe+qbsGgG6JOMf/2P8BqYhfp1sTyLslAc/eQEC0hi0RjN8QGnqWRQzmtF9xUXQ0GC
	A0xcf1EMNji6ULKTKeAQzP+i3zN2CCqy27xdAivY5m2h4M59z/648FvV1DOiC3cnvY7Wjosag/P
	GOd60wYarggHW8yy484rnqCeheVCyhUIYhnRy6A+1qW2NUKksu8TRPuat3AQbkP5VrULErHZQ/R
	uubYIGDsc9zN9+Hie8ZUGeR8QzTN2LHQHM1L1Y+bLqdslXGP2wJlqAs+EpfL8VAkq951+M8DWha
	hSPGTXuTE6TlFpNvD4dEmqip6FS+u/5UpMBxxAS309Mf6Co5IFf/LsjxcHIh/56ivr9rZeOnnq6
	FRw6OQbkTlV8hJjxLeEx3NsQ91IbcQyKIrVSRepe7VnqUN7GeTKCVlKTPtZfHtpFj+iw==
X-Received: by 2002:a17:90a:38a3:b0:398:d6e8:f84e with SMTP id 98e67ed59e1d1-398d6e8ffbamr3534533a91.9.1788107088286;
        Sun, 30 Aug 2026 09:24:48 -0700 (PDT)
Received: from user ([2405:201:c052:b00b:fcb:65b0:addd:e3f8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9e907fsm21087126eec.25.2026.08.30.09.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 09:24:47 -0700 (PDT)
Date: Sun, 30 Aug 2026 21:54:19 +0530
From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
To: syzbot <syzbot+b197a0fb4e741cc5030e@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, david@ixit.cz, edumazet@google.com,
	horms@kernel.org, krzk@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] [nfc?] [net?] memory leak in nci_send_cmd
Message-ID: <apRZM5ZkGw7KQq4-@user>
References: <6a942714.4d659fcc.734b4.003a.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a942714.4d659fcc.734b4.003a.GAE@google.com>

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 73ae59e975966d24e32926247ddb45a537ebe184

diff --git a/drivers/nfc/nfcmrvl/usb.c b/drivers/nfc/nfcmrvl/usb.c
index c7f2afe00b93..7a4094797ba4 100644
--- a/drivers/nfc/nfcmrvl/usb.c
+++ b/drivers/nfc/nfcmrvl/usb.c
@@ -224,12 +224,16 @@ static int nfcmrvl_usb_nci_send(struct nfcmrvl_private *priv,
        unsigned int pipe;
        int err;
 
-       if (!drv_data->bulk_tx_ep)
+       if (!drv_data->bulk_tx_ep) {
+               kfree_skb(skb);
                return -ENODEV;
+       }
 
        urb = usb_alloc_urb(0, GFP_ATOMIC);
-       if (!urb)
+       if (!urb) {
+               kfree_skb(skb);
                return -ENOMEM;
+       }
 
        pipe = usb_sndbulkpipe(drv_data->udev,
                                drv_data->bulk_tx_ep->bEndpointAddress);
@@ -254,6 +258,7 @@ static int nfcmrvl_usb_nci_send(struct nfcmrvl_private *priv,
                                "urb %p submission failed (%d)\n", urb, -err);
                kfree(urb->setup_packet);
                usb_unanchor_urb(urb);
+               kfree_skb(skb);
        } else {
                usb_mark_last_busy(drv_data->udev);
        }

