Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305679;
	b=AGA3oALJuzxT9HN3FZDYDsFVIP9JsqCkhNIJfz0//j+k6T2VdzXhICaThUN3PCsGjoqb
	 ULUykBrgRsIrPcOC+88m7rOTVd1oj/w2cqflooLzHq7HI3qYvBw/wvrlVt5DQQbhOIsoW
	 Id+X9iDZe+6WD1QYvlbnT1WUKA5HuJ4//fjL/E1grVcep+GizNZqftr+FIeL3aqLFogxA
	 4pGG9Kb9vea9z9DNfsKOQXHRzQYsZ+31e7P3w6v+oG/fQhuelc4aljq0R7hPjdFxxKEDu
	 ZH1HE6v05G1KcdreREm323xFWWzdpthY7/9Alf0isBS2EGoFBdzJ3a7deJRksrP6DrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305679;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9WFltYRvNkpM0HMxRLJxGiCTEiP83WtKPHu+oXy3KTg=;
	b=e9InvLiUeB5cgiT1gXccpvIhZ5shthG09rYo+LlKrn4+sitN9TbnL7014vC4Led2zZOa
	 sk/O0j6rjI+y7EPn6XP+MQ9AywFwYI8H9Nt0IOzw3COw9OrAeg9V4ThjvP6nWePVzJE/v
	 UXzYczipDn7I6ZuA/8e0C7KAy5i2SJnseRJDICC7++XW8hI2ei0IvKOMzIxBT77n0K++U
	 29TmK95CFKEqoHMcyMlNTqya48x1trSFDy6s2aiaBLoA0HcPzIN+9QHq/GfzErHGI7160
	 Nz59OXwUhc7AqWGpKw6Nb1VhAQmYjY9XDZCH3YscCZZbtexq6qTk3+WpgOaHjjh8W+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DrlQYRb4;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8237C606A33D
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 10:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8237C606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DrlQYRb4
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b56bbf8330so2383289a12.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794305678; x=1794910478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9WFltYRvNkpM0HMxRLJxGiCTEiP83WtKPHu+oXy3KTg=;
        b=DrlQYRb4d+FJBQLFk4gip1vdMb9pZcbFm0QRoW/O9nsnnIGk5B/dcI7komCKzkv/uM
         Uz0TTkL3EB0XOLA2v0TTxwYvqDOvah1wiwbB4uUsiRRXfj1OcdvtnHWnMQS6yfKTNN5Y
         2S+sbZpFj/oUd6OIfB1K+t4luOgmpm8MRta8dNUBz+XdEb16ui6jztHrAySR2QYDDBtW
         UcH7ksMk3kyTCuhLg24n4RSbgP43bR1MD63YWBBHbNHKba+s6Adtgd3r0iiTavTYgvkx
         vCBmyxhjfzRfUpjuhY0K7x1CK/3uUIf/0FzbTbFW5bHu/k5G1xko0Cr6O3LrrObY61iA
         y+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794305678; x=1794910478;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9WFltYRvNkpM0HMxRLJxGiCTEiP83WtKPHu+oXy3KTg=;
        b=bvONKcHeA3cSVwNyvFmwMD9Ip7bGjNEk0vrUG5/Ol/29HA18syT87aYQRYWpHVMpKm
         UxYof6kKOdzte+HG6GLg4WhMo1lJLBinRSI2YaM/psM2pdb8K2x6/FOqBBBXSHJhCCyO
         9HP5GMmcpErkIk146BftAk6+trhlMz9tAtn+02WAOLVtpZTDwVwKBIhKo1HedPfcTSmJ
         mtViNTi5oG6Akc7/A6LR1H4ucvzmHg+XFfGWY0NETDAsfOiADOV7hJEa1AeeklJVHNXd
         2bhTHPi+VRDwtEmuAPWetyVq5EeQbyQDYiQf1ux/5YnMbPy8h7xF+/yyfgu3ljP2SODA
         RdqQ==
X-Forwarded-Encrypted: i=1; AL+hErEXdVkKn3YdYtGibyYyiyWR+aOHoahz9p2IyIfvozha/E8nDgKoFYROS9JeIXtXeeuMQiny2U0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Cg5c3pbj+r8Q2GNkK6nL3hkL7sXu1G2mEJ5pcJQMZwHot2ojg
	EE4ZV8PzjMnRQ8q6SUtM2cATyxCkKX3yyYtNy/dmt6uS5ZFny8SLLXPXrlp7OqAv2wc=
X-Gm-Gg: AYBFou1mB4X7W2upbbI4qv2PpdUkoL3DmXbAYA5XCIg6E3kPsS/6Rz4QOkxq/bbffri
	EaqRQ8OzGLlkpKACnirsKNdlsR7r+kBrp8HxlDHgVlUL4bFLr0RwiR7NB3N1CroCYUklP2Ydw8K
	1YTXE46DQgA24PRGx9Nwhla0DLI1jVSUnGGsb5mbMChFEBqHxY9WCIsZDkiyBR8xLyv6SWLoKHX
	kkgcYQZLjcK5z0Bym0+OYPRQq00YaP/W/7eTGvSmvz+za/wNgqCECtxEUWzTXI9JDpToPr1I8rv
	9UT9q8vaGANcmAjXvEAW0O8iEX4xQAy1kzk9cvrzt6k5tyd2B30rUuZ4BKGE131xMqf79Klf7SN
	epTEyyGky2u9suBpZjQcIgAXBsV+s6I1XdIt67UIS02ERwwjBpcqhvhcZxEsqnQ6jXlMTz4jEI/
	tfIkGAh0AaQhY0smIm1DIK4BivPh3hHv7j0vpOwTBWjz6DPpNmRj1oiirB7Fj+WpMm1v06LnXhC
	t0hlkGD9fj2XS4EtH/qGDbBfRksK3H2fvhE7xDQZzQ9mHvPDlAB9EcEZuNvIU1u7UC46r/lLe+q
	071/HPyBb4lp23qxTXwRRLDnpw9WSD1U0wA+FKcLGqzsrB/SkT6rxKRWovZEEzx+I8oGZZvMS2Z
	GdM2FS4pC2hlA
X-Received: by 2002:a17:907:944d:b0:c41:4c20:5a80 with SMTP id a640c23a62f3a-c504963ce05mr189793966b.44.1794305677695;
        Tue, 10 Nov 2026 02:14:37 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a593eacsm90433466b.36.2026.11.10.02.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 02:14:36 -0800 (PST)
Date: Tue, 10 Nov 2026 11:14:35 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org,
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 38/41] fuse: refuse files on pseudo filesystems as
 passthrough backing files
Message-ID: <avLui6Mpf8GbKbtc@amir-ThinkPad-T480>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
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
In-Reply-To: <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>

On Tue, Nov 10, 2026 at 10:14:54AM +0100, Christian Brauner wrote:
> The fuse server can register any regular file as a backing file. procfs
> and binfmt_misc files are already refused by the stacking depth check as
> both set s_stack_depth to FILESYSTEM_MAX_STACK_DEPTH. sysfs and the
> other pseudo filesystems aren't. Reads and writes of the fuse file would
> then be done on the pseudo file with the fuse server's credentials.
> Refuse files on pseudo filesystems just like loop does.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/fuse/backing.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index 8c21a8a74efb..4e4fb810ddaa 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
> @@ -147,6 +147,9 @@ static int fuse_backing_open_file(struct fuse_conn *fc, struct fuse_backing *fb,
>  		if (inode->i_sb->s_stack_depth >= fc->max_stack_depth)
>  			return -ELOOP;
>  
> +		if (file_is_pseudo(file))
> +			return -EINVAL;
> +
>  		fb->type = FUSE_BACKING_PATH;
>  		fb->path = file->f_path;
>  		path_get(&fb->path);
> 
> -- 
> 2.53.0
> 

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

