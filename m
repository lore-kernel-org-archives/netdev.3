Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA067306B3B
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929347; cv=none; b=dC2iYPRZFmFJSE5vhuRuiiFgy7KGTBiEvzU1M21yDrCtEoCFrmH52QYk43BTk6EnA3UhSXR4iJlK6KNOHBmPFeto0ebIYlGzbqNslgBA+HWcdyEh9ZcBRepwugNqVAJxnVT7iU2k3B4vRCeWWYDVR6OUCjh2eQ1D7dLYEm13Vqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929347; c=relaxed/simple;
	bh=DklPH6/6YJ0p6u4Cf1PUxpd4itLk/dZorR5WDOT5W/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crSk5LBiiugIxAam/qQYZXEdrYjJ3uprBbIPm2hbe1JhXFJuPMzCLtzLDBM5oKafZlRjNwJGw1vrNGQujuJVxQEdAxRzuoay0moIfsv7ajKWr4mL2q3C+O7RMVVpjviSmzbzbpyFW2vF2/ge1n/DIStlh4h5Z/N+Jsd3CpSqvDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=khNLVBj4; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khNLVBj4"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-83537a80ab6so1230958b3a.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 14:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777929343; x=1778534143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JKpE5oRLemYbfg1MRy2f9zZjvjCWWH6F7jRfRxX1jLc=;
        b=khNLVBj4s5KuwBKGO9lJ/eqFzIsaK4KCG4wxZKNMPcAQ+Wn4tSOkIMa7+xeZfkE0IQ
         3wFfDaSM7aKJ7tAOwx6mOBeiBE8WMDL8FG64mRwSytpDDhYTVV9zxqzFnf4qocem4m1A
         Q4+h3WMazXtwwGvMdIgRuCns/ULO/NE5Mm3eZM+xBwLC9RJ/hmNkmXArWF+P2FqRgWpo
         kzPr/bJT6yDka0BgH8kQ15LdJqv5zEe13wipN0AXPaf3EYFO90kmSlHvuu2A7FxuV+TW
         qgI7HBYuOt+q9qGHJvR7VCt2OMa3CA41le3Fc1UEr9pkg1REKRRIeN+65f3hhLviS2Si
         tqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777929343; x=1778534143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKpE5oRLemYbfg1MRy2f9zZjvjCWWH6F7jRfRxX1jLc=;
        b=rZ+mQ/hqeRa0KTkI64bc1NFxMdS5HEGa+PB8tkmyH651PAcePE2+DQAYir7rlsw3DC
         GmL0FtHgcsk8X/tmeqF7ZjHftY+pW/Yi6FyOXshUtnE9HVUMcuDQUx6l7nxgm8j+Om5Q
         vBIVgsQ9E/lJFrsr2Vd9Yoih9Q7twbTniJOYI45zE4DO1pl0ITPfC8ex6cSTN8BMxXam
         NOUtOhsoPc3HRpSeeHwrxi/Rz4Hgu9n0emlzqKRqjhuKaR3B4KhtQMW3G3LYfAdVjDGN
         SvzXa7oGGY6zOP6688QeWrrOpETOMSX/QwHh2rcnQ5AsZIfHRCZHEPf34MXMVBMyQDRJ
         bFXA==
X-Forwarded-Encrypted: i=1; AFNElJ/jzhKgDT257uE6VBe3VrQec3gDlupy8WjphsXTEpwAiPo9yf9grMYRi9WkdZ1IsJ4B1GbLdhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZl9zqvFmBooro4O94YOv9K8f+63d045Jwn2ncGtLWsAKT3Z1H
	TUbYMnNiTbo4Y0O+bPet7uSJ3wZcPpvK9YzbtO+EmIxiMkOW0CFF82LvsWlXMPMNYA==
X-Gm-Gg: AeBDiesne7Cegr3zalP3wdZiJ7tmwx+dsHdYKxf0EuYryB7TVRciKaBV/0FO4wbMo/w
	xYR29O3qbVh5vlIHPLlCByDuDA+y1PAtsSRx0agU0tkxGwP4ynz8uaCQ7OUIf3Lp55qKxNDGNXr
	TwV9UZd6oRRbiasgA/iXTddZ/d8Q6acUgKYKthqSZTtwJlDkylJhf5wR+cfu3tKwEe6fczRLEYg
	OlFN8RG5fpXFTMmjOonulV1CKY7ZAk+R4MqHjHE9IgeVajnBn99cEs3QZ+BLjv7ljSzcD/pN2sB
	3P/A8MbYxqpQrWIDa+mTCyawjeKS/rw+ei7ifX00VEJdDnqOCqIlmfCNiunuIuoJBJFb8QORyyg
	JHX7C1UnX/K/7lyS8mJ2QnhIYD6drvt8waxwrrmKg0ufcASr8NZG/+uTS/dtqAFHBPZa+jxvOp6
	o5ZiMkrCZMG6W0mEmBbFm+WbabD31FJJWEiquJNenVDXZJt1gbL5PgUdCZVAJ2oQJn76r8SsxJ7
	Z797Q==
X-Received: by 2002:a05:6a00:428c:b0:829:9a7b:db84 with SMTP id d2e1a72fcca58-8352d2f425bmr10106522b3a.49.1777929342450;
        Mon, 04 May 2026 14:15:42 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83943dde006sm41031b3a.10.2026.05.04.14.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 14:15:42 -0700 (PDT)
Date: Mon, 4 May 2026 21:15:38 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 08/11] vfio: selftests: Add dev_dbg
Message-ID: <afkMenQ_gfmLUJIy@google.com>
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <8-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>

On 2026-04-30 09:08 PM, Jason Gunthorpe wrote:
> Enable it with a #define DEBUG at the top of the file. Allows leaving
> behind debugging prints that are useful in case future changes are
> required.
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  .../selftests/vfio/lib/include/libvfio/vfio_pci_device.h    | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> index bb4525abd01a22..2d587b988c09fa 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> @@ -38,6 +38,12 @@ struct vfio_pci_device {
>  #define dev_info(_dev, _fmt, ...) printf("%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
>  #define dev_err(_dev, _fmt, ...) fprintf(stderr, "%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
>  
> +#ifdef DEBUG
> +#define dev_dbg dev_info
> +#else
> +#define dev_dbg(_dev, _fmt, ...) do { } while (0)

Can you add something to make sure the format strings are still
validated by the compiler even if DEBUG is not defined? (since it
will almost never be defined). e.g.

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/assert.h b/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
index f4ebd122d9b6..406c430ef28d 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
@@ -51,4 +51,9 @@
        VFIO_ASSERT_EQ(__ret, 0, "ioctl(%s, %s, %s) returned %d\n", #_fd, #_op, #_arg, __ret); \
 } while (0)

+ __attribute__((__format__(__printf__, 1, 2)))
+static inline void check_format_string(const char *fmt, ...)
+{
+}
+
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_ASSERT_H */
diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 2d587b988c09..3abfa6ff481c 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -39,9 +39,9 @@ struct vfio_pci_device {
 #define dev_err(_dev, _fmt, ...) fprintf(stderr, "%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)

 #ifdef DEBUG
-#define dev_dbg dev_info
+#define dev_dbg(_dev, _fmt, ...) dev_info
 #else
-#define dev_dbg(_dev, _fmt, ...) do { } while (0)
+#define dev_dbg(_dev, _fmt, ...) check_format_string(_fmt, ##__VA_ARGS__)
 #endif

 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu);
