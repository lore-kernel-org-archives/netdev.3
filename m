Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323279;
	b=35xiR/QCRszGeEvugrm9snTsd/w32rXlIIvwaUq+CrFSt1byEj9LHXWtgb9nDosmdwIU
	 0UPhX/Zpnuf79ICztW9N1jjPsB7q5h7f6PgPYu62E58ySBjt4p28MMYc3ES3CTTzveCcD
	 P8ro1hXUFdtiUawhm3p2T3tS7sjYAmuFTYjUcLr+wU78hSDBYeCJfldAkC4ymttm9txt/
	 TVJYFC2iSLytIYypWdxlCYUZCMgT1CkJny79/QmYgYyGyQJU8TRuAt/bfBFbSUPbzGZ/u
	 BxvRzaKExmLJVLayf3/gWHbhpXf3Ks/aM8lfyuBZSwRTwKuKY7CGa0akiP0h3k/sFqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=JtM9UtzYhAWCxTCfoBKbcmHIR3U4Wq7tzdw7gboBY64=;
	b=U2fZhU2azM6DM4nzjUFLHxNWpnpyF7izGNm2IPlaBS1aKe4lth9PKEZDYAqCoCephAea
	 Aj9nMeca0XGWpe02lpNaDBAKltS281ePCKxxZnVdFf2R/qokDCfIShybC6WuZPXpq0GER
	 EmYDxvXI6miKHQ3QvRACAsHiOjJbl0uaezh6g9XbNKW4gGigsjiWLNmP3uGDYYu16ug2f
	 neIiFvbBd+ep+BqVJtQgFeLnPhYNrA/HoIUHyGlN6DrIo2AU9DczEc3V7icYpbhByvo+z
	 GEbwfNQxo8M7RFR84AvUxxbteor1503MiCPWBGSxRU54Ja8Kmo/sX8Qz5Fv2mH9zhtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LHozpx7Z;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207EB60A261E
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 207EB60A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LHozpx7Z
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ed2b4348fcso8360985ad.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794323277; x=1794928077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JtM9UtzYhAWCxTCfoBKbcmHIR3U4Wq7tzdw7gboBY64=;
        b=LHozpx7ZkQyIUBsAkv4C311vzxfheFN2pzrL9Y/FTHkEXQzaVUkMAz9U9wFUejAOr8
         YATASi40x9WcOvyF4dkS6SJQ2bBJHO0yE68WsOT8oewufPXMhMYT6O7d4/5H33a+EMHR
         jjCu1KqktdAA/9c8ZIpbjFjA/3BLyNbgEZc3fS3F9+PTZ5y3jCgkJQ9rhGft5ONP+cJO
         aTEF5vn9sQP8UWqDXO8UszNcV0yZFTKvtrsUk25y1Sz/3h5njQt9uj1PBQLO+FuWPgpB
         LsGoLTWDE/iFYFuKD+GJLya2PXFipxPXM8zYDthkWkjgd0549O004Xgoom3qc/ylK84T
         vykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323277; x=1794928077;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JtM9UtzYhAWCxTCfoBKbcmHIR3U4Wq7tzdw7gboBY64=;
        b=kzxCSHGgtTDw7bfaN2Gj1sM0fZxyJ7Xy87/ccsf80CfqPcB1zg3rI7GsX/bDoHBuv8
         Fx1g8SxOyxgDtJAuqsG24E8Z4GZzLtiORvHxLQ956wvq1uwO+xmwPxkKzRgfDM/YS2LL
         ok9rdj6BVJ2yWY37/LZjzObnUDhq3k8f7xBx5CRc27KP7H9Yvugnssdvuaak50W/7dCe
         ycJkEXc0BC2i0kRpVdN4qQh2NkUvfPqtDe5Q3QEGZXmdumPosxOSqn+Ebif+fqlBKUL+
         JSw5SLphvbLN7deqBznhbRKbCF5Fqjke8BRy4NmDhiqYjAl9ZnX4U6Ua83OyV1RrWJJN
         S2sg==
X-Forwarded-Encrypted: i=1; AL+hErHPJBmkIMOiEInnbtB7ckTp8Oo1cayBebKCPqmKPPspz+WEeTD7NnVwgueomCXVWdKDk1535dE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KUo5iBiMi12rAnnn/0Scfk6TIacsn74C+TuR9x0iCztZ6Ftwl
	83Vq6d/oLHWQaGf2XUDWqqx/t8eov/eauqqTpxjiQ5BeutHqhzXF+k+J
X-Gm-Gg: AYBFou1OZHsdBTJoPXl4BU8OKOwqWc46rnL+/58FxnJotRAMDvQYPcQop41/cLaxthy
	wllgbjn+qljIYb6IScLiPInjaV+bm3VCVpOek3B+9VVjTv/gmsOeLBOCM9FlRuzglspIbGE2DpW
	I+r/LmKW7Cfsq5UDVgJXDDU76az4Y8xXgmlEc40qIqfApCX9kiFl4PuiPLUJxU7NVeNC4dRZ5zr
	3BE3/zhaFQTGsCBJmSN5JMz2TwDuLiIdBv44aCahYorSBWInu83ZtuPRaES+Bfq6dWGKgZFwYuL
	EGLZOzREJ/KQqTyNlFKTqsa4THDq0TLqMD34caTn2ex5zZvsvkzN0V8a1nqHMcppZX5yNu5bBB6
	unn4uf+uTIeC5d2gggeN8vURP51soFCR3vuGxmOZGQH0H2G3XypuSxeYsbcdw8SndpjtwPRVuZX
	h5xmMYTdMHreODciso+xpHZ4WSZu3BQ2/sGzy2kpIA+KgeofDUdEBScpNGHprrVDJQxBUp57hyv
	fwaDU1Trf53bJbLDlJysG6tRa+Nhs34sQKn+SOt11plccvJQtEEMoeVzFxgqW99ylgPzjJ62p2c
	56g7l2vWVMIrBDDbNzkWJNzNdMZeBdGZhAr5rFKOTliY9SoKDeMF7N27jSABdJYLQfwfH2Rmhd4
	k6U9tdAu6jyc=
X-Received: by 2002:a17:902:d481:b0:2ed:1ef3:9ec with SMTP id d9443c01a7336-2edb9172a2dmr26826345ad.14.1794323276968;
        Tue, 10 Nov 2026 07:07:56 -0800 (PST)
Received: from [192.168.2.6] ([27.75.101.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d78dbcsm10397575ad.27.2026.11.10.07.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 07:07:56 -0800 (PST)
Message-ID: <71f76e5e-ce24-4a71-863a-169ad262c510@gmail.com>
Date: Tue, 10 Nov 2026 22:07:46 +0700
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 36/41] nvmet: refuse files on pseudo filesystems as
 namespace backing files
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>, linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-36-4c998976c6c7@kernel.org>
Content-Language: en-US
From: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-36-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/2026 4:14 PM, Christian Brauner wrote:
> The file backend takes any path that isn't a block device. With
> buffered_io=1 that includes files on procfs or sysfs which then get read
> and written by a kernel worker on behalf of the host. Refuse files on
> pseudo filesystems just like loop does.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  drivers/nvme/target/io-cmd-file.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> index dfa8aa46188c..71c69bac5394 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -52,6 +52,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
>  		goto err;
>  	}
>  
> +	if (file_is_pseudo(ns->file)) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
>  	nvmet_file_ns_revalidate(ns);
>  
>  	/*
> 

I noticed patch 41/41 doesn't include a test for nvmet. Would it make
sense to add one with buffered_io=1? The test would need a pseudo file
that can be opened with O_RDWR and supports both read_iter and
write_iter. Otherwise, it could pass without ever reaching the new
file_is_pseudo() check.

Thanks.
