Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B86423793
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208708; cv=pass; b=fqP5969Q5rUD6yLf8XvkBjxW9X4nHrXyw7E36mrPTeUAH7MyNkouC7KrtbmkiJ3cE7zxSERuS7l7knCFt0XZfuhdct5P8dKYbs/0l68vbW30NpSC4hDAeDUpN476sF3fwFjXWVY80TxLJqQ7LXty+FpCPTMyyZknwfg7ecwHilo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208708; c=relaxed/simple;
	bh=xc9S3c/xNsKaxwTz/5Yxl+QfgtMe1+bHg58ONELRULI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVja2G9XfoJOjoySfVomibjPA+7K9+edMWtWQ51QLoElrcc1zEonOvDrmes5JQBaC0WkbgNrsSlUPsWnmsvGjnUA3VmKKvNmn4DqAYpWBblYKXE6jhPQIcjJcXLOVvASCAiEs9Ix4mYWTZ88f8af2oQGDN5ru202Xiq6dTPuWCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKgGGzoJ; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKgGGzoJ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-848643382fcso7434420b3a.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:31:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784208707; cv=none;
        d=google.com; s=arc-20260327;
        b=ZKnZ18TwGtvpRY0pffrv6t0YLGd1tqFYtB8mYvm66JeWH8k1IZeB11l+4ZRK81gPbB
         ssPoa1ePg1a/07cgSinqxAmnIKSAyfKWruafeLWt/I0jr6ZBjYfEaH92696/IBrsRhO6
         fMDk1d7c2xVRFu7miRo+DqFXIdQhFRlHLCqwkW426/6IswD2BArqEU5fssq9B1GzF0J3
         nPfws8at0DVEQXVl2NStidBupKYwqnqo+fT71tXjarb72mxlYq6LRVo75kTepRU5zbSc
         H5iAGNFffMsU7cfyzSt2K/PZYcOKEa7TP3v+2pLVMQMthW6wvDwTEYCN+/OkGWuAgj+c
         B4Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xc9S3c/xNsKaxwTz/5Yxl+QfgtMe1+bHg58ONELRULI=;
        fh=djlEFQtGkMH0bjOPAZnz+Cjn58HbFiA9x3QsgsG0/T8=;
        b=npOubdOIILa5RV8Gn3sMiWE0c+Lh+9wwVx2r0osIPI8YrGs2TNo+dxzEwGgQ5rg1ue
         +9WrMm0OgjkCbiiutnUfkNjPvOVQPKFoyTmUmz+iRjuXMzzSEmEK2/2SMDffMAB2RSue
         T19n76QJw7PvNY07DwufElSpAGOrrvGf5CDUVru0BDo1gdYKYG8Gcnf2PCD8cQaTr0FP
         x1xTOSj2FzHvEfe4sgbyo7muM22gSpVtsiHYnN17VHfGvAHL2OUn+MVcdjCVWYcqeJEl
         T3ixevFSITEpZdIFuNHPGOKdnvb5r4UdtQDUhWd4GtWGe6mxutlaiVOPC4HxhAKw1Tm1
         zksw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784208707; x=1784813507; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xc9S3c/xNsKaxwTz/5Yxl+QfgtMe1+bHg58ONELRULI=;
        b=cKgGGzoJXyG9YXgNQ3UL9mGg9Yro8Z9rUNvZNMbD2mWwtPpStS+cY/xIuM3HfrTBt5
         dxrXW+Od/ubio8prnPhiyNY+8oTvEynQ3/xYdrMGL5yr50ZO+yq4w7+u5r1A/U328tQH
         AUXp1HPEM88kpF0KM/a7vLHAGAggENIQV16a72ztLG5IiLUY/9cjxjx1qz2uvmEg5L13
         J/STDEqFb6Jlb36pbObiX1oH22yY9BkyG2+Gx2OV/+B5MH5fDqu1ImCZGk9DL/+K7KcX
         2oyrIEOj3nJZ4GjECL92y7KIFwMrP9FxfGirlMhNKO1XfEuwrwtFUFik2UlDJvswEtuP
         AtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784208707; x=1784813507;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xc9S3c/xNsKaxwTz/5Yxl+QfgtMe1+bHg58ONELRULI=;
        b=huJfU4KUWZtTjsLba4g0D+CtcHHVw7UCkS6w9f2KwzadbjvHg8Yd4AwkKgkJcgtVWK
         kDJZuKfMxynZakzqOCE/3geLc3Iwkcf20BVoiC/8a/BNuwkuA9lUCVABMB8KuPQk8LyG
         tFy4Oc+ZsRF2Uv2DRXWZkjk7YE/vMu5ajYYLWwN4KyNt1f+L2Q/VGpRDxbyEmnAJ3dMW
         dqpWbhv/e0lkNnwIxrPTN53w2POEXnwwnXFh/gtXAZqwLiBTpjXJldbSONKGxYEcLuFT
         cIp2u3iBujGun/EOQc1aprZqcX0fCQLOAKZJ+exIXqxPewUW2xEP2yv09wNYXvHKIp9G
         a/Yw==
X-Forwarded-Encrypted: i=1; AHgh+Rqy1GVk7iLWXgW7zmpZFYktXG+bj4L9NCS+He2uhAKsj8mlylcuddofnEtNWmOGIS+GFShatIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxApNwJFqdun0ER1W+l6cCu2C9bQ8pv4zRqsiMfSOXI2M+9gsG8
	787Y/aLzXjhgCgoGGMCKkqS8coAJQGPraa1/EH01di0+xpB+8nA3m6h8s9jkvHdBPF7D8r1vco/
	PYflPcSexhnLmtQOvzvO+ne0sujGPiqs=
X-Gm-Gg: AfdE7cm9e69VzV5QiehRAouSMaPVB1H4umsbd7KRp9q1pqFwbvxJwYppLcM4JfU2vLQ
	fLGefXfLLnR7ZOAlA/SNZrCivNo2IBq0BsCQN8lGzL1CYY0hCswXJ1GsgkuzAAl8nOTvQAKNHWB
	3TEjBNUg7T/g/tlzOF1FHdX4X05bUOdtc9ff2nILxLEpN+aho88jWjD8YBM3kc2wVguAczQ6jqb
	r7OwukAYuSMVibtiqx9JK0hHwbDRaWxKghnC5IjfCqn53q89yefr6sPnlI6LFiL4LkBKIBMxho3
	x86I2zVUJMMJ9nZUQpL0olM23Wij3f7QfRqjLBWytWemvRHQY2RivhyX5xxtTB9tCmM1pvjBfk4
	0im+GLCKwGrjVufx/Gw==
X-Received: by 2002:a05:6a00:3319:b0:848:587f:8acc with SMTP id
 d2e1a72fcca58-84a5162f709mr10179967b3a.54.1784208706567; Thu, 16 Jul 2026
 06:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1784033357.git.roxy520tt@gmail.com> <390cd5e91ed60eea27b0b64d0468301a9e73b808.1784033357.git.roxy520tt@gmail.com>
In-Reply-To: <390cd5e91ed60eea27b0b64d0468301a9e73b808.1784033357.git.roxy520tt@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 16 Jul 2026 09:31:35 -0400
X-Gm-Features: AUfX_mzSqFy0j4m8l7TfrH8k3EUCCD1rj9O7PFk_y4PpSTTmkSqPxAXdVXUBAo4
Message-ID: <CADvbK_f7du2s28mJ=DsFm6dE8u5xaSbd=EG_5sL+-HKYfUuCcQ@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] sctp: avoid auth_enable sysctl UAF during
 netns teardown
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, matttbe@kernel.org, yuantan098@gmail.com, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn, 
	tpluszz77@gmail.com, roxy520tt@gmail.com, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 9:50=E2=80=AFPM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Zhiling Zou <roxy520tt@gmail.com>
>
> proc_sctp_do_auth() updates the SCTP control socket after changing
> net.sctp.auth_enable. The handler gets the per-net SCTP state from
> ctl->data, so an already opened sysctl file can still target a network
> namespace while that namespace is being torn down.
>
> SCTP previously registered its per-net sysctls from sctp_defaults_init(),
> while the control socket is created later from sctp_ctrlsock_init(). This
> exposed a window during initialization where auth_enable was writable
> before net->sctp.ctl_sock existed, and a teardown window where auth_enabl=
e
> stayed writable after inet_ctl_sock_destroy() had released the control
> socket.
>
> Move the per-net SCTP sysctl registration into sctp_ctrlsock_init() after
> sctp_ctl_sock_init() succeeds, and unregister the sysctl table before
> destroying the control socket in sctp_ctrlsock_exit(). If sysctl
> registration fails after the control socket was created, destroy the
> control socket in the same init path.
>
> Make sctp_sysctl_net_unregister() tolerate a missing header and clear the
> saved pointer so init-error and exit paths can safely share the unregiste=
r
> helper.
>
> Fixes: 15649fd5415e ("sctp: sysctl: auth_enable: avoid using current->nsp=
roxy")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Co-developed-by: Qi Tang <tpluszz77@gmail.com>
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

Acked-by: Xin Long <lucien.xin@gmail.com>
