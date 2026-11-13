Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564785;
	b=kuIjN68PhKX0EOgldeAkeXy9N6TUBPlQh1g58ZjC+ULMQkMfujzq7zNpsMMSAemU4kEO
	 S4rJE0ECOTnPMO6Pkx9T8VgtoMV2FaPfyBTVBG7Fsj+3dAQWl/FQRZ6ZD5h0fIFjSS2v9
	 heEk61k90UcYHRtA7qchA42I0ySmrc5iwmLx9TxLwCSdBIZmhCcUHZW0WGLg8I8JxhdZT
	 Obfj/ph0SZZ1xBQC2/D+2WY1DsL3CWdUrKBQtKpsvTIdyzfeU7uHDrcHMfbwsaebuurv1
	 srHXVVma+Gx9Z09m85eNHnfOh8nhZ1MbWq7Czmm1lIRuQiy3Xqx847HJOOEzYSEcU3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=PGZ86VpI4/X6bkLIqgY54HnsW6MSps296zHbeFwxlLU=;
	b=0+cUqiJUiJsefhPl7SFjuIeetRq9SxotwScuereM3shCb1lwCWQGvaXXb0a12j7Ukdxw
	 UbckumfaPypcJYQCvzBz446SVP7IkHG/zLFUzD899xPWmQ9qN096LSpQdujZS6bUjpWvs
	 14z0MeonzZmxf1uejLU2rLkSbRdUa/ddWNlC7xAgArqALwIA4u48M3/w/jkeOj0m+ZQZH
	 HfvM7lWGAJt2TFRCFjyXtkFxXmO7WEA3zEUBV6OIF8ZG8oAjHQV5b/Me3JXS4zTUantwZ
	 obJV7DSLaORY5tFkzta12RU7GjiedEtB1Yj4MHeSuTFyuvFVQ0RdvA42DQCjxot37ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qhgXZLcH;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CB8606A898
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2CB8606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qhgXZLcH
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so10467155e9.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 02:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564783; x=1795169583; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PGZ86VpI4/X6bkLIqgY54HnsW6MSps296zHbeFwxlLU=;
        b=qhgXZLcHEG/xp1ftPxi4Y+VtkR5xPsdZusiH6E7v1UVOpu+pQQwW0vkLZszWZiEzcA
         +BIaLUI7scE4yUL73wk7QDgrWayWPrLwdz+Upaai9wvZdfIC4mpAyM7/MboFd4cm+sgl
         6S6dsMSsgGsAMWrOW2SdAqPT3x/sY2fNDxpywpmU57N6cPKU4MQNdvXTLk3fPNzTNPjQ
         TN2vMd0rw8z+5ZJqFwtlFaNorLJKFpgZtePYZzAG9uux/UTV4iwPxrV7Aluh/WlU8Te+
         mKwCC2bzY5T7ZateqcC/h9wnCcfLq6dmSfmWCE2kpyRSPYXephvqiHzXHW2gW5l+Jqy/
         ZrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564783; x=1795169583;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PGZ86VpI4/X6bkLIqgY54HnsW6MSps296zHbeFwxlLU=;
        b=XaJScPsJOAGoidiS6FmDh1Hec/YroXuNiX9GaXgStDpL0WIHFKgu8osFW4VzO7/jAM
         TuTe4ZDpg1irU7zK2w4fVn4/7rpnr9PR3XiECFJSQd75L4jd9xgQQRkf13+FfP3y3Hbh
         k4kczBxwDhONACaDQrXdiCQLANSlTaU+D+WrKcNE+327b7ymjzPutHAMWLWoWJBYl4ND
         cUT5TLMWduwJndE+KHM6f6x2uM0mZkgdYn9u+jd6xy1sqdzx/bWeJYOdgvv33d6NCu30
         AOtFNIJoKVMn+p1+2scA4TxEpdMO/s7I8Fl5tGTuuQqtF1yujbVol3QiEVjZr3Fsz6ts
         /kbg==
X-Forwarded-Encrypted: i=1; AL+hErF6kJVdKc5DWSbEtUUW5FUomjZY65HiunTWmJPF2RP+Yp43nkYGKqmFYyauW2stmYPxzwIdAfY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vte0iyQUh5ywKWpoRdSk80gFgTn7dItdOtHoz0HsuH7yG/uNN
	JkmKYhlPiYmyYBkJ2sGpAsB+ehsFqs3jRWK0zKG270beudMH5cVoyR9beZv2bx5hUF6I
X-Gm-Gg: AYBFou3cGt16OWS6CR5u3eSQB5vLmq4FL5O4w7DrlhF4Sl5DjV+h+U0MBLX5QGDdAcI
	65QeP6MU+QnY93pnfdvVY6e5dXzJnQWijQspDAXeQNxPz75bwt0lfTaTNcfoEtVjgbsSg9oxVMA
	p8bqu4otGPxVMgj+PwmOd6vYBW6h7EYpnTgEEKQ1XSzMFBLsLWqkPbJfxKE5baKsRT19e2oGlES
	FLtam3GI6slFGoTKPKbqn3LVZhbkoPr/Rr2AJVUEMKjGOs4J4NRzXVehgaB7QC8m967P/T63uxO
	CXmS2O5OEfpV8LUo3V0cEqwJ8wq3ZxxRDW/OVdSsj4cV0wCKHE427QwCiSFweJh0qKv0FfJMKXp
	Yn3vd+xLDLygxuYb8mH8u6yBONOd0Zj38NYFBE8HQiOzsYI1VsAFMkQmrTorOKMQhUIaJEHLSuy
	I9NCylJyxXHVdDZSEbEYfKW0wEFD+DBZU924ONtQx4BRVovfUJIscHFoj4R2QKUA+yrNRWgdLoe
	G7t9B51dG0ZbyYXkOofvJDyxP6ezgQJ4cFTH9hQ4SjuZvpZ3uEEsEyHHOoze70a0ThvyYfOFl7U
	IVp3NPDIJ+Rw9ED4gPRO3Atx2cgdSajPupycV3p6qyU+6EnneVurymoI/XmzWI16
X-Received: by 2002:a05:600c:4f90:b0:4b7:6c16:7b43 with SMTP id 5b1f17b1804b1-4bb55a47602mr36814615e9.10.1794564782834;
        Fri, 13 Nov 2026 02:13:02 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5d2872edsm4056955e9.12.2026.11.13.02.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:13:02 -0800 (PST)
Message-ID: <94dfa5ec75f4479663dd79f3ce05c1dc6c080185.camel@amutable.com>
Subject: Re: [PATCH RFC 22/41] sunrpc: use fc_init_pseudo() for rpc_pipefs
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:13:00 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-22-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-22-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> Initialize rpc_pipefs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. rpc_pipefs never holds executables
> or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0net/sunrpc/rpc_pipe.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
> index 9d349cfbc483..37277a6d2415 100644
> --- a/net/sunrpc/rpc_pipe.c
> +++ b/net/sunrpc/rpc_pipe.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/fsnotify.h>
> =C2=A0#include <linux/kernel.h>
> @@ -1181,6 +1182,7 @@ static int rpc_init_fs_context(struct
> fs_context *fc)
> =C2=A0{
> =C2=A0	put_user_ns(fc->user_ns);
> =C2=A0	fc->user_ns =3D get_user_ns(fc->net_ns->user_ns);
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &rpc_fs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
