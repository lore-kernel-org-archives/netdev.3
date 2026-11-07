Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794069869;
	b=aI9RcYEchJU6J3FPOBwO/2s8TLBdVCIFgob25v1/Uqi+BKw1JIdfNzWosE51Wj9DhLeZ
	 DAmw13xCGwclCsEQzmfffByETHaGK3Bbz7vQwZoQ6rF+PB7dPfXIeIss0CQT2vwtv1Tvz
	 SZ0Q0wMfvVdVNT3CNaN6L6QSefQmNaB+gkhgDDlWeJHXNuxHuL/7l2Wn/fmpkxnmWOO6j
	 wwhMyg7Rabp29pbeo3LPC88sBls18q/QtDuNuu/lH40zR3gHKrL6kLdGsWrUKTJkjMl/h
	 IpyQY/Bi6/Wke24AUOCKNJlBKEiqTMaZatccFmVs+Idm2AuRP2De2TSAxpY7VwFrS0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794069869;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=G0TBUyhmKh6st027cPZY/A7ojV3HiUgM2XJr1Qt7yqs=;
	b=KqU4BZ4QzQmZBYHye+TPIR2QebbcVs/JzCVAczsrAhQrUKdPVsB+JQOlN12gDSqLY21/
	 oKEsya9tw/uuYz5V5PDSb28XfhntvrmW33ln/fwysWYoLdOYOUMjWju8YZNlPD+P8hLz3
	 7D4kwGdYdI0UgZ0bbAAHNcvgPVndGIwxVL+qb8CkBpK1XS3VMsTxsSxAqZB9IYpCo5zBY
	 yZLMOytab4ZIbkUKiB1bqiZr1JkD/mK4jT62rJPHqsxjxMK+VOnP1dlyaYyi6eWNUP1OZ
	 XVvj7N96TkpfQ5pdTFzZXiAOOHzTKgvaHSYPJA5BSvD5b5Q1IzaYcjPYWfSpBDvhg+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JKM3Q59n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFDA606A326;
	Sat,  7 Nov 2026 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JKM3Q59n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AE51F0089F;
	Sat,  7 Nov 2026 16:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794069869;
	bh=G0TBUyhmKh6st027cPZY/A7ojV3HiUgM2XJr1Qt7yqs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=JKM3Q59nuGthKfZZ1g53NfgMW5HMOwAz8SvtCVAUy5C6vBUiqAiUNN0UEIPX3kwJW
	 /J3Yre0ao/1b/ou1YJQQ3uwfXcIVYD1Kfk+s+hVe0VcdXnJIfOa+ZBxhVDpE3pWjQj
	 yqBRfpA4TvnhcienoQiIIeD24rG1KmchQ4Bp+PaP6sS6awD9cqkb0HcFrvViCG7G7U
	 r8PNjjHaGtPUyVzNI3t+traTFiHo7pgSiBhn902wKJ0jQL64jrO4w8eyS87Z+Lg9u1
	 eeDcR76duxvrGK0U5dUlvP2g3gzKvHw9Ku4/vM9fT425eCUv2/TVx+HUKAHzy8UOsh
	 D7EcyxJfxvf5Q==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2B907F40066;
	Sat,  7 Nov 2026 11:44:28 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 07 Nov 2026 11:44:28 -0500
X-ME-Sender: <xms:bFXvagUcXvb8MnJJHN3hgE7xTx7IZRMQdlbP_ZEb8PD27gvFrZtCtg>
    <xme:bFXvavY_aXkOt4Y4cotTawA3gwfSS1igrTAMOojsEECAYhvr3TLu1QEs_L5BpVeiL
    41Yz0ScZQMj0cyEjRmPZcvhlxbVwjI12GVwPzNKR2mg44gwvxAQFUXzmg>
X-ME-Proxy-Cause: dmFkZTEafamBgjRPORwDHNpTB11RdeQHyhQiosVcrYOF9LB5P6jy3BfKWJh+xmkiuSxOX7
    tDN9XqOURgu+f81F80jLsEw1qYuiDBRWEOKONv8WPHXbdZQoErBdiupHwPNh8RIwh87+8J
    UgZ6QqaKPcurBWRuUIEifnOeCtRe5N6WcVW5AGtRwIrkdZwXnZm2FABVu2BSd7FMrxUGEG
    jvRsAuzXwxIzAk1tI0Bn4dokKUNkEpaj0rmTSFUd3l9aHLenuib9HfbXf6Kcl3xJ+PrQtw
    kFv+0T1XRsABieuR4Ahw3twhnXfv8yWv4Lv/4qp27Bn6zJGuli+6GTssjSp+V71cAuRIQC
    M2ysJB9V/Jn9h4FR+cY7ZZwkxqmbBKhuQ1ZqDsLvkXpoHfsO7QZ1UMMkZbz0NXllVjZlgp
    Re37xYbpwBwYeT3gQBZFNkOJ7uJCydkm3mf5GfNuB5S4lqUqX45wf8D6s7m3P22+1SNJLu
    H2zeeRcC5x9ddfMe+ZFLWvBYI9IZO4hzlz+GqrwbYsWWJrNF8U8D/8w9oEAd6ay6P1EmK1
    ryJqp0zZtjGp8C+UGtteXdZW8HBL0rArtOBmlnFjVdRLTucekVyIKr/9bgm4e2gDhEXK4z
    P3B0SharSOuNV17nHBjBMMgzN/u8+xHArXwWJUliC2sBnxCMgSa5+6gCprEw
X-ME-Proxy: <xmx:bFXvao5U7t1N1Npygz8dQ6ytr_F85bHS9oxAT_dkJRX8_DW0AUnM_A>
    <xmx:bFXvaiGly3czQn8opBKIYeuJNHWfWdnYT1dNuo5YLHkKMn7nu6aCjw>
    <xmx:bFXvajC391l5re1CFHCBUCYrs7n0eDkdM0lC-STG8LAnDV4Jw0c2Bg>
    <xmx:bFXvanylxr-2B27EgbCkmvOcc5-daW34Kz0IAWmukcQUT9Tz53ywag>
    <xmx:bFXvan4h4C3d0U9dWIjpI9X9u8BCbK-2_V3HRELvyaNyx87PWa7U98rk>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 12146782738; Sat,  7 Nov 2026 11:44:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: A37rHgw9iumg
Date: Sat, 07 Nov 2026 11:44:07 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jann Horn" <jannh@google.com>, "Josef Bacik" <josef@toxicpanda.com>,
 "Chris Mason" <mason@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Eric Dumazet" <edumazet@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jonathan Corbet" <corbet@lwn.net>, "Christoph Hellwig" <hch@lst.de>,
 "Greg Kroah-Hartman" <gregkh@suse.de>,
 "Joel Granados" <joel.granados@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Jan Kara" <jack@suse.cz>, "Jan Kara" <jack@suse.com>,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-s390@vger.kernel.org,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 linux-um@lists.infradead.org, linux-wireless@vger.kernel.org,
 "Linuxppc Dev" <linuxppc-dev@lists.ozlabs.org>, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org,
 coreteam@netfilter.org, kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org,
 linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 "Takashi Iwai" <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org
Message-Id: <a04dde49-8373-4687-a905-10c3a3b89492@app.fastmail.com>
In-Reply-To: <20261104-work-procfs-net-v2-8-221e2437fed1@kernel.org>
References: <20261104-work-procfs-net-v2-0-221e2437fed1@kernel.org>
 <20261104-work-procfs-net-v2-8-221e2437fed1@kernel.org>
Subject: Re: [PATCH RESEND v2 08/13] SUNRPC: let procfs copy out reads
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Nov 4, 2026, at 2:59 PM, Christian Brauner wrote:
> Implement ->proc_read_buf() for the procfs channel, flush,
> use-gss-proxy and gss_krb5_enctypes files so procfs copies what is read
> to userspace after it unpinned the entry.
>
> cache_read() takes an iov_iter now. The rpc_pipefs channel file passes
> one for the user buffer and behaves like before. The procfs one passes
> one for procfs' buffer, and a read still hands out at most one request.
> A reader of the procfs channel file whose copy out fails, a readv()
> with a bad later segment included, loses what was handed out, since the
> request moves on before procfs copies it out. If that was only part of
> a request the next read returns the rest of it. Both flush files share
> flush_time_text().
>
> The procfs files are removed when the network namespace goes away and
> that no longer waits for a reader that faults on its buffer.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Acked-by: Chuck Lever <cel@kernel.org>


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)
