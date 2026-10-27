Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793136044;
	b=lPK1Z47PFIyhdpDnlqDmwTcrMWs2ATkz411NqpuHzoXHlKmwwnrSZKd9Tu0OXb3PJBhU
	 TpMTvpJMBMZgyyZSjI0l8bNsd83hzi3FCMu0nWgQEShdqtrcIJDmShu8KOO7DuBmjc+lk
	 pPC8Rrab3HOsqsxZGgZLXN2wEJK3uUuOE7PeXFovBv/+ueqPa+lIzdON6PMcUX64IPwxJ
	 G2x84i+BumVZzIJMhDBZ6bffxeX5bgoZvU5Og58C83XWhGKj8ialGWwpqe4vdIUAEuBXo
	 Pevi/StHyJ07DN0cjHDMBQavKrsJj04RdM1rnWRfr90f8gnhieNZgQzgdHQPYaoLFaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=//BXZYGDoNIYbvcfKVJq7nsD/EmdFe6Y3+UxEejuz8U=;
	b=iqloXCVDuJi9Vykn+BpCJzpF9AjxkhRYkwa3x0iT0/2Cmc7SsiIWTvo5C2QNJ1KxfHiA
	 ZZ7dyP/dulWN8jchczrthSdzXsdEHy8G1jMLUZJIhgoQc7xpYgOgHpWVAUa6z64VgYhgQ
	 dhcEDA8htSg8IAK48rcvvUMSbNQNrAFK2fNWHMcwS6swDBGcXykgJNcJBNsUx4vWIv13V
	 9Bs6q1XIRtpfzCWNYa+0lzLwVpVgr2rD73nAPSZPYwAif7c8P9e1pXYIKeexdXSRTv4Xa
	 JKDtfR+oYYsJttfHZWLVbL0deA6CmSBMR76aCMzMo/12vQLOspmom0BLUEIbJCPADOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=dE5lYTOB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA0C606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 21:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CA0C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=dE5lYTOB
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a39e5161c1so254841b3a.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 14:20:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793136044; cv=none;
        d=google.com; s=arc-20260327;
        b=Z/80mEXH2iuZGXElK6aP+6aM2IVHVxITceoLaNCkphK9hGI6Pfj+Yp9ZrUk4W+PQ9N
         ZjT9AX2+l0Xbm8yo7ehN9snwGDvd+xFV4phNU5Vs3CunK80/NK+V3Z9Kaq42Hi8srrSa
         pzrjKf5h5JjEW90sipNtp2hEm/G13zpF4d3S8xHSddddEABYQNYnSfRhPL6iD80Cu2rj
         0fIlQVYwkMDMYJ7yNniVD3oQQ5nYgUKg+bEbF125KLSUzy2/rc4o1MSV3NhwVpt0nrjA
         Chmp8ZxoAV++SfMkpYH3ANuM04NGxkzmJUADQzFWWA4OHN9LWxSlAYRfnUaSQCg+j93E
         msBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=//BXZYGDoNIYbvcfKVJq7nsD/EmdFe6Y3+UxEejuz8U=;
        fh=rYeIiqOgr6sHk+QvgtqGjeJtJ3AstNAWniG3oAOgTzI=;
        b=pJ8sGgF7bi/gCyzuS3T3durcskhP9VRlp6Fz+1nTylaVEBsCZA4AkCwvvLp7PE7Mf/
         fN6ERNoCZ3f2H9dR4RCwEjWBIRcezL41TaDyJFsWvWU9SPVpCWdZFNqJJ0k1gcllxQON
         eh/7XER4/YUuMJMnYcaacN/OMfebdNx3vqeScBjOq0+6OJsqZoF4iecn+skRZO/ph5WI
         gbz7QaRu4Ubu3US+OiReDBuxftKODIOYj8e68zBMQjgqyF1kFbfDVAr1JGJFje8bU3Pn
         /jmalE/tKwsx32mpX+OaSxOW3g+S+9Fj/DKR8Omm3IGXpWSBod0RetLCdF6jRJdRRT8I
         MIbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793136044; x=1793740844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=//BXZYGDoNIYbvcfKVJq7nsD/EmdFe6Y3+UxEejuz8U=;
        b=dE5lYTOBipuAXZK5EznTEdptwg47sgdzCDRMd9ej/unp5IM9QQir75hvSI77YxMkXj
         Ic18PLFYr9/e1yqbYRi+j+Ctdq/Zb3hqx7AZ2FtnnoK4sb2XgGzkoe+2GkdGp9dTTyJ4
         lHLa7bApzUAz60Ge/WAmo89RlMqPnk7/TnNSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793136044; x=1793740844;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=//BXZYGDoNIYbvcfKVJq7nsD/EmdFe6Y3+UxEejuz8U=;
        b=FROREb/ue3Xbub6nbUMfnu8Lkp3xKtXh0J4vWQR8aFDbXGfKFlToNem/xUEx608tlR
         DZonOhRRarrrW7BUSI9QxwWy7bK3G+DJh9+twWJQU7ZWf0pJV+JhW+UcbsKmE8bEtHY0
         soyvpBAyRCJPZh1Zt28Ei2PVZmiaOSYTzvGTV6jdmiHo2ytMXkrp0koPC6t+/9DYOAt9
         r1l9GNC6Gy5SAqTDaluIByHj4IxWf3NamEP+7xvJhpQRwt2FyJgHcH5LoafCDylD8oOe
         /UmxNYf/Te1Laxe98VN371gY1JOQNqeLllAW5qJlC4bYjjZiZ4VTY6SxsSWPP3srZuvr
         2vyQ==
X-Forwarded-Encrypted: i=1; AKwUvBzKMGxhW7gyoFuKabIlEtRpK2/nGRtt+3Qe6M7MBnvKzOOkCAM5QCBTnY3SlBNUueqJN/2gTwg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUSTX2s/zLnKVva4Tm8teOBmlxBGoKP9aq/DqqRjHNt/2s+eP7
	juhRxPN1C++gNVdljesoCxpvZP8OL3e7CG1jtzWNOv9Op1QrY8A5T0c8TgCaHP9BglWbgCzOz7r
	yb20Z8b6kddHIBYYOMWZ4dSh7IBjw5A/N+40611DM
X-Gm-Gg: AYBFou1aScxQdexb6loEj+Zf+D79y9joHsfG31kJzTV6SdGIniYOLUzu3YrflNt5s4x
	5Hg90JDUb8whYAcDaHufLYtfVxtS/6ZtqIz8Zh/8zmLIEeC/N+gpCdm+RAzBr7MGHi3DixTqS5f
	DzgzrM8/0HOrkdKMNcwh33Jr/0UK73rmBXx03Jqb62t0EWFMnqtAM0l03YkwyshY87udMcOVrxL
	00tLbltX6/p9+108DIs/SPffKTaH/RXeZyWRba6h52hgmSAi4hnR2SSVvXcubUSnXMPl8+deIB9
	2Ap2BeFlKuwFwnKr3w166+4FE4Wd1+S5IfS5KJiQn9hEDMCFfHsA4RJiipI/mSdkoYQmtDBQ3Wt
	+xZGFgQaUClH8GGbeTg/v35mKr8g5/gXdRtP3xSkncRztIBD9x4BWz+Yfe49EU2Kz7yqE2cmtOl
	Y4hh1b+EzLtlj1oAj642/nM1c9oNpAdVj9tVvS
X-Received: by 2002:a05:6a00:8f0a:b0:881:e266:c3f1 with SMTP id
 d2e1a72fcca58-8a6e692142cmr384326b3a.21.1793136043838; Tue, 27 Oct 2026
 14:20:43 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027082604.1485903-1-edumazet@kernel.org> <willemdebruijn.kernel.22807e0fe104d@gmail.com>
 <CAL4WiirUmA1GnUaZq5MQgENZRo1248YSo6AOYb_OseWS8p-Cbw@mail.gmail.com>
 <CAM0EoMkTUK1cvNbeSvyOGLQ9yxQfR9-TsmQXXZbosbX+pz_2WQ@mail.gmail.com> <CAL4Wiiq6KJigDcqu40raE09Deets=rpMRLUBTdqausfVRAMvqw@mail.gmail.com>
In-Reply-To: <CAL4Wiiq6KJigDcqu40raE09Deets=rpMRLUBTdqausfVRAMvqw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 27 Oct 2026 17:20:31 -0400
X-Gm-Features: AclHuK8JOjKUfHXhE6g4aa804vwXCUuwZbhT9d6zFLClbgc0D82aCUJ4NMtRDyA
Message-ID: <CAM0EoM=uKi6pN1VjdFBttTcSBAFc0Ajh0-Ku7L0QBYdk-CXk7A@mail.gmail.com>
Subject: Re: [PATCH net 0/5] net: fix eth_type_trans() crashes on skbs coming
 from the stack
To: Eric Dumazet <edumazet@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, Jiri Pirko <jiri@resnulli.us>, 
	dev@openvswitch.org, Ren Wei <weir@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 4:34=E2=80=AFPM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> Le mar. 27 oct. 2026 =C3=A0 20:48, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
> > I didnt add my reviewed-by or tested-by because i wasnt sure  if you
> > are going to resend and include the patch i sent?
> >
>
> I think you should send this patch as a standalone patch, it does not
> depend on anything in the series.
>

In that case, for this series.
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Tested-by: Jamal Hadi Salim <jhs@mojatatu.com>

I will send tommorow.

cheers,
jamal
> Thanks!
