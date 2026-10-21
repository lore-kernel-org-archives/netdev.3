Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792592819;
	b=CLBtbCWLQGjGTyalM+zvRsxB9ngU30iGHfMgueSoLS/Yvs+PwkJRGRV24wVV2yWeJtvz
	 nQv3u1G1DavlftGNBc7csBn3yCE+Onur2dklIJ8b8piCEKxuuw6pLdOgi5GwGEYx5QV5z
	 6BlHGLwkaAiwkzJlYZ05WMymZk79DioD6Gc3/2x+joMlTASDVrgl1P4dst0Qo3TuljEZY
	 N7DciDmJinUvAM12yufX4TSK9w6hXumwb+vBsOFiyX2xyAXxnPkv7f7mjcuVeDm7kRD6K
	 YHrtBrzMk2sx5gdoZ5GvRhRDmYTpFupMbctZUK83ljvj2RDAu4Y6yjTz8x9WrxJn//w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=HZWCDTWe8myvVLhLnC3gRwnDw2Z9dfDRU9KvUScIux8=;
	b=FaLxz78ixxYM5XndnwKJhwpBDFcmLZ1r6vC7TDVt+xqjCDPm378OOxQmrBNaDeOpcM2n
	 wBL3ozSwzwJ7/Khb3wZIjfYhtyZFq4vg8ynK03xc4HO4J7vgCut16TX5RlUEpnHXRpRpu
	 8JU+6Au+fRVTyz6F6XMdTCaL9w6MnzoIQHgVp7xCEbtSp61Xt5fdv3W0gt80PS1isIesE
	 QuQ7hcKvYNW0wk199pEdIrgj+11VTmzm3kQ7NM9aLTlj/3zhsLYadkVcuW5shtWFP9xwF
	 G0M1BCLUzvjdZ5jBe4IEdXDiujCRfk/urvMWlMhxnJp1F6VKgSVPEVmFrS83DJPrNHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BRqHAhOJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F007606A323
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 14:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F007606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BRqHAhOJ
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6ae14eecc64so1078713a12.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 07:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792592812; cv=none;
        d=google.com; s=arc-20260327;
        b=q9v/we5S4uB2QNAYrzT6LofnUlSTodza8CewhN90KCeBbCLx2JO3knHBsMh2uODMov
         vwsVk7Uz+wemjYk4nLgU3qH/vQSp8DaWEZV636gclb1W8tjqCzJqb/Vq6CGMYIL/d05K
         SgPNAyTo3d9JiHsI6vaC++d+6OqFI+qDdF19fovq4HbFpAl8HhMevCdcV8BET081ZJhY
         KpkQKwj/JyH+GIohaZqXMj88XamcXefbHmXKbleR4zjk/F0VYoE9yeenMmtYbrIqTGAL
         jOrcHZwofB+duhSfLFWUmPU7WXbBY8q+jz9Hf1n572t3BG5MinuYwKWFXSSaIpQRtDDL
         txBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HZWCDTWe8myvVLhLnC3gRwnDw2Z9dfDRU9KvUScIux8=;
        fh=fsnggUk5u56rpC50QImJi+tXcOlpSMqAG/wyNchnIYU=;
        b=ai2TcZ+iBs23CjOJ/5dJ65iKWcHxnk044LrpDcDnztPI6E1UtKYn/GF6zUaiedHLUr
         19JaPYvfKG+oRQIXcPUqNWsoSqncUrwXuKGzH1hCEwFfNY1iwaMRHOmT5Px4ViDgdcVZ
         OImeGlvHKWcFmdKYaud+nyVZ73hHxJCF1kPa+vHUusmVgHd64eZzPnSwgRqA3siWKuIH
         sKkTg5Vu9oSg5/V9NCsxtaV5ptKNTFeXm8klIaURV7/RH2AmU7QeqI16Y5//UZEB4fVG
         6bETxKDiT6RAC/VgudytqSY5VrMfocpP9kSJ+mu8Iel4NW4574os5LsRFCm9hRXdmkS/
         rzSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792592812; x=1793197612; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HZWCDTWe8myvVLhLnC3gRwnDw2Z9dfDRU9KvUScIux8=;
        b=BRqHAhOJRFQGCZ0436cerbXsvDGcjOTtcEFCOpJRV+nbVKbSAKMl662tBLFTfb2Sg5
         NFxQNyHoxxgYHQR13h13k71ankQp/N0fxgwfPZdFZZwD0LZwBvhOQiky2tnvBNcGVE92
         vpRJ7hzp6lhKrZveGyDGkQ94JZjS5rrim4/SQCOenhyqo5st97RuKWVFwTkWZQ5bTbIw
         iWX7FjROAHIvHplEaKREmJYGpSp7sUQFKLAPhXVjYlSpM8WQnUK4iSviJf2DCzgxJwf5
         mmlBS+ISZT3vDsrX9Xx3+f3KYgz6TnHUVdIwJP9bY9OfNIdfJdTh5lFsIo+qwhCRzOmH
         nAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792592812; x=1793197612;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HZWCDTWe8myvVLhLnC3gRwnDw2Z9dfDRU9KvUScIux8=;
        b=E8LpuqCCUDlSc7/lgUqxPIV8xPR+b19b9RACSBthh1t6iQKQKT1qs6y5k/1mj+ZuGf
         ACqdF5j72KSFhsfikmt2tSA+Go4VjY4aoMHDmXtXcZnx3GN+7/r2l5BFTEQVc0GO+86W
         ta1+BaQqMNRW9cbS1J74B7RIrAXXoM/kql9lirwNRCxM5ubfh2356k3EURwzdmpJCl8q
         8/pVV6mQC0Z44wAAph0O7Lc+Y2tmK2i9dn8E23s327lYX6iszbSoviZH281hkiK16pXL
         SvtbzTUUEQc1WZv1L0IdYQj0AFyNsdWPljKbBlyP954F1QGT/yAgyroBheFNezUC30Rt
         2fBw==
X-Forwarded-Encrypted: i=1; AKwUvBykhvPkp/mD3TSXjD+SUlvdM2BmCdDezewH3jiq0JlnH7D42c2XDYslpsk+JP/bkDMz4JSnR0I=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTFuGVqU9qjYKgC5H3TAfAUC/Np+4riXpJ3pfxYSnm02AKyroE
	bBPgwELIWMut7NK83nZaO65xfxZzO0fb7d2eLVfKqDyI4zVaJAQrp1QzBU6q5oRTuJco29QOgU+
	LdY4RDuFrkWvkaMxsjtPlla9bHj8i7I4=
X-Gm-Gg: AYBFou0p7OLHbz4UqXLeJGVw3d92V0tHolSJWd6jx4YTe232dXoX61+7doygONUII4f
	rl1WikFdOwVn7HRTX/z22vzEK+tsog2lspeh//SkkpaDfM4M742m3r3hIrar1xiJYFoqmqL0hFl
	x0PDuK1aCVTpl/WunNNSBs/Y7R7cLyx6Bjfsa3/uUBtPpXkt8Of+0xx49zi+y6zd56mYMJSn/ni
	05vllAw0OuiTktlN6II0dPj0Kk6fQ9zJrZxDsCPQflEr+RZ9oBwE8SKFXq/ggUi0mn7K4OJMtX+
	boMpMCAgXDthEaKUZ7s7ilFZco8JqoNVgyx7uWtWKfvqX9Xnugkev6X0Dou2tUJhF/fKkldg0G+
	PL6ZFxaoTGd5z/9L05l+TfKNBfLUe8g9E2qpV
X-Received: by 2002:a17:906:c105:b0:c33:ca5e:8ddb with SMTP id
 a640c23a62f3a-c46796b58cdmr190770166b.28.1792592812271; Wed, 21 Oct 2026
 07:26:52 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792552161.git.jan.koester@tuxist.de>
In-Reply-To: <cover.1792552161.git.jan.koester@tuxist.de>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Wed, 21 Oct 2026 16:26:15 +0200
X-Gm-Features: AclHuK9oo5ZYObAiFZur0ih7xDKEBxlKdO-BvoDx6w0mXhpoTx1_PdEXJcogV54
Message-ID: <CAPJSo4UJPnhLFAYRXE-_M2_Nin6=Ff02AjayD10cB7946MvJDQ@mail.gmail.com>
Subject: Adding dreaded Windows SID-style, or. Repeating history, the bad
 chapters. UUID/GUIDRe: [RFC PATCH v2 00/41] UUID and GUID user and group ids
 (*_r system calls)
To: Jan Koester <jan.koester@tuxist.de>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-nfs <linux-nfs@vger.kernel.org>, linux-cifs@vger.kernel.org, 
	netdev@vger.kernel.org, audit@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 at 13:24, Jan Koester <jan.koester@tuxist.de> wrote:
>
> Hi,
>
> this RFC series lets a user or group id be a UUID (RFC 9562, version 4)
> or a Microsoft GUID as well as a classic 32-bit number. Processes can run
> as such a user, files can be owned by one, and credentials, ACLs, keys,
> System V IPC, sockets, signals, audit and procfs carry the whole id.

Are you Linnux guys aware that this is just a variation of the
*DREADED* Windows SID that this patch tries to introduce, just with a
new name?
Maybe, before doing this, read about Windows SIDs, and why they are so hated.

Secondly, the whole idea of doing 128bit hashes as UUID is not new,
IBM DFS had it, and had many iterations of security issues via hash
collision exploits. 40 years later all this horror comes back. Does
history really have to repeat itself?

Lionel
