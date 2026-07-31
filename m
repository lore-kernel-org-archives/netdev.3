Received: from arkamax.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1174436729D
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.116.240.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486074; cv=none; b=ZmyFaWQYxVSjn+0hTltfn6Gmhjmw6b+5qLro1GVaa4GW4NXTChkFFdT5R3UjNg/VMHY87ZhrBOpX0xKicbZJ35X1nF723MKMTguUuNkm9UoZiKYykwb0LHmjaGawmQ/kvZwYYBoMAZmYzkkhAQncsDyhmvsxuug65ZmCvvjbYgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486074; c=relaxed/simple;
	bh=RNoa/guj+h++8IkZvb2F6gHdY2uJXx8VET2Qj8a4VlQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tr0Lhk4jNbCBJe1p1a6f5QFm2vI17tfeW5Iz5HzYwhjFC47LxPqdWuoV7J2MG3MA5AAJnOF1u18XFNWV71yprAv3L4dFHbLxd0C0P6b5u0i0fcF+PPPnXp8tY65dB8l56zzr6I4+zCNnabVKEbTSL2oadIlxe+siemELv7JGdXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arkamax.eu; spf=pass smtp.mailfrom=arkamax.eu; dkim=pass (2048-bit key) header.d=arkamax.eu header.i=@arkamax.eu header.b=MCV7BlsX; arc=none smtp.client-ip=128.116.240.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arkamax.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamax.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arkamax.eu header.i=@arkamax.eu header.b="MCV7BlsX"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=RNoa/guj+h++8I
	kZvb2F6gHdY2uJXx8VET2Qj8a4VlQ=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=MCV7BlsXs2wYbuQtoetBVr0jY/uc7b4N1dm+v
	U9OzCUqaK3HUTEPTNps7sM9FMV5dRw8NZw9DrbcRCtDKbLewtzwK9Hs6WxkoH8PPGQVzSA
	OJD9sHVvgpFzG0IJWGVUBkR4fPuqVd3kV3b5ul5RBR3FACs2eEGRl3zmu+i0Nxf2ITgNPI
	IZT37vBoAoUY95CFZ6FGztp8C55o3do/PEILmoLqelRTplCSwXBMMSh1AcB2K1hMvLKPcL
	oE54JlP85ABuS0bYjS6NVV/iXVsicC9rIHj0YhS+s92eJ3ea/zTL8s5V3GOb6+CMPm3CpR
	eltPBh/llBuuFepP84CmXWggQ==
Received: from localhost (<unknown> [193.207.98.130])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 5010176f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 Jul 2026 10:14:28 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 10:14:26 +0200
Message-Id: <DKCLUFJYS7HH.2EBXAQNUPN5B2@arkamax.eu>
Cc: <linux-nvme@lists.infradead.org>, <netdev@vger.kernel.org>
Subject: Re: [RESEND PATCH v2 3/4] nvme: add debugfs helpers for NVMe
 drivers
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Nilay Shroff" <nilay@linux.ibm.com>, <kbusch@kernel.org>, <hch@lst.de>,
 <hare@suse.de>, <sagi@grimberg.me>, <chaitanyak@nvidia.com>,
 <gjoyce@linux.ibm.com>, <kuba@kernel.org>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260731073918.614014-1-nilay@linux.ibm.com>
 <20260731073918.614014-4-nilay@linux.ibm.com>
In-Reply-To: <20260731073918.614014-4-nilay@linux.ibm.com>

On Fri Jul 31, 2026 at 9:39 AM CEST, Nilay Shroff wrote:
> +static int nvme_debugfs_open(struct inode *inode, struct file *file)
> +{
> +	void *data =3D inode->i_private;
> +	struct nvme_debugfs_attr *attr =3D debugfs_get_aux(file);
> +	struct nvme_debugfs_ctx *ctx;
> +	struct seq_file *m;
> +	int ret;
> +
> +	if (attr->get && !attr->get(data))
> +		return -ENODEV;
> +
> +	ctx =3D kzalloc_obj(*ctx);
> +	if (WARN_ON_ONCE(!ctx)) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}

Just a nit, I don't think that raising a warning just because
kzalloc() returned NULL is a good idea as failures can naturally
occur under OOM conditions and aren't bugs.

Maurizio
