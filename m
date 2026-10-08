Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5402F3EC80F
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446504; cv=pass; b=J0j+9lLM7mzwB+aTU2KAYRlxCM+6+bgrEg3xZ+MseCECDNlzUgZEXW/Frbj2gGcsdLQDBgpcVXoylssbTBFMKRhMm3YsJApd2JRylGN+aN59jkN9UOaAqCwl83UXbtDphxL0ysssDqP33XDq6+k10VV0qWTlu7Mmjo5pkKD8Uns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446504; c=relaxed/simple;
	bh=R6nAreG5dHBsQuH2nuqKg9p2FY/GhdxubP7/yDE5muc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYdMDWH+F1yVt+OCZ2q5YWjKvIk+kTcWqhMXdyZ7KH7PwzmlJkdY4nGG4quWNPyI8hIWicpi02QDpvPpRfDPSoHdEtlxuVe1FDVUFIFWe1SijBl5j1NxjY/suNuqngewgIze1nbMeK0NgVcpAIx6TK1plXPPuwXOdJzEGVsCZro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M40mbaAU; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M40mbaAU"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2e38b61974so11277766b.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 01:01:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791446502; cv=none;
        d=google.com; s=arc-20260327;
        b=cLa4J0TTsz5bawdsJ4NNguzswB+bes8dsfOFvlBgkv9jAjwp0+gFq+ogrd7pkdOlcy
         K0SB7xGluty+b4pYu9SXKcM3nSjmmedE2uw19gLmLVDhL8/fvCNf993h6U3bk4IQnXwB
         7HAwAKDJo73c5qmY5KMsozaHCLqxv0H5or54Ir0wCqTYMJN41CFYLlWhnDqJaksz/o8r
         VUqm6fjmRBOsIKgw5m9GLNFmTCFF3v1OtKbdMpSuPzqAa8AmNzvaGkwwm00Crzo5NL7B
         kCbUT5BgGoHEL2+k8TFGZj/GEcfO8Dl5zlvnc/2z/RlRnXW9FUd4cwC4W3hJ2pJtT3N9
         DqpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VPO3NQmYgI3jpB+3gN4RVKiWcaKRTUg4yVkiuK0YsXU=;
        fh=oxp7mOIBPUxXzgLt4fE0LYB7kYAGs+K7txBPdYDUMJE=;
        b=DPTkx8rvDAUfnUuw/jRO9XZ9e40bw3pOjqCRpU3EFD2IV4ymlm1GCDJLz3KsJyd/o/
         JeQ9o6dBz/8QBNZaQ9UEIxR+GAa1OL9SXo61IXmNGDUmkHD9bhDh4wUdj+AdTSxSWIUV
         823gmt3bRTKo6i2i7JOpjmiP8efyzDGly3Y910E8CzsY5SngXUPKovCBRVe8MbIxUCd3
         nxRe3U/jVySIRsIoOvDxTyieRcYuh755trBXZ78gjZKiX94+PVwNnt1UQqtPeWbLJqQi
         dIjfewaidYUUSEhofNohEpONVRkk4pDbL3Km0O+H7LMmruqe1AkYDa2Bm2J3Ilaka8Lw
         i1Yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791446501; x=1792051301; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VPO3NQmYgI3jpB+3gN4RVKiWcaKRTUg4yVkiuK0YsXU=;
        b=M40mbaAU/Gn+59DUGIfGSOs6kK8wKryodWBOBOF/f8KPJhSaAjY09LNfziYU8I8qXh
         NExf/vKRwtFjUvZjw5bDJBfrxMNrSNdTQbZQ4my2vw0XSwvZTnXGQ9qq/Ckn+/RGHkMz
         KpRxdlh9mLyfjFCKlm7lj/9339N9oOt/reTLg5mfIz+puzdi7AgEDrluk4RB7ZRUlgK+
         5ryEosYPUsM2Ix92GzLdo63Ivnm6BinHA1GGL/Hx5Ao+TmP6J41+Vb0EVAozzhTPGWXn
         sidR26gpxGwwi5vJtq+4tLPL5JHy4ffg75dfEmOCueuODHg9t6uKytP6wDvjOU3CK28Z
         aGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791446501; x=1792051301;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VPO3NQmYgI3jpB+3gN4RVKiWcaKRTUg4yVkiuK0YsXU=;
        b=FLK4aPDZ9kQFhJ+GLuNHkAud5WbBBv43s/gC48YHfl1dK3Wd4qfTheINDBgTaYaScR
         DgeRsrSCeO8h6ZmG0pGJGWQlE514YYTk5UOQzARdg9TobpdKXy+Vxv9mwZ5tXCjI3eZ5
         ay5aC+TNV4dCvh01ekNBrquJThkZtpn703F8VBZel6TtcaHW12qoydekdbfpiFy9tVDF
         UuQ9OT7pIKnoiWZ1PaWBx6KxGFaqYtimb+c/ugJHg+73mySbhPzVkLHWAqdPEITy71/x
         EymKN2UrPpycxQusMrHMzJm+l4Pm61fITBttrO2mOdpaa8EyJx50ByE/djzXM/qKlNuT
         XIYQ==
X-Forwarded-Encrypted: i=1; AKwUvByd/9is5Wnen1U84d9r1E+IgfGhlBRw91ROsyoGuL8mmsvGtNFuFksmbzGJGsz6FjzrG9kH8nc=@vger.kernel.org
X-Gm-Message-State: AFuF++naq2UVV+rIxrkz17qhVhT1i06uGYjm+/YnlBK+uiYPtTQ7WfJm
	lWbFF4+s2ML4B2ZJnDWAWd5nIXY3/E4KKY3Tvl9fcbL902ptdXQ9/BYYn7sSNvvZtSQdHZydUco
	YsCKv/JPUr+SiFeT6dEBTMB+3dTeyubM=
X-Gm-Gg: AYBFou1FA3OrvrhpOzUgL+VTKzXZdxOrew/12XT+fV7cqlz9V3A26Pdaa9G3gLPXGpY
	Aq47Ft056hod8T+RRegDO487HDRQJ7mNQJQEdXXBJNMZwLJxrNYKXV1ispgsGLi12NrAIkmIHAB
	93/fbsBq0b4rGIohCTUJwCEnHcSVJVK7jbugppP+TVaxlArtTyRzP+JrNLicKyGUBtG1e8qpFQn
	KiivQnAKfBc+IGMmdZVlaWAjEnZQmscl6bJXmE1zIadpLYLtrqkBIV2DlpZpJLFDulMCWDuHp0Q
	Pjbz5GO5zqdLps6KGLdMfrXgW3K++HAumWJn1+CjQCJgXYgiiYYISKIe+HVyAjdL/L7hmf1NKap
	EvycBCOHUz70DqtJnO6nCZg==
X-Received: by 2002:a17:907:2da4:b0:c2a:f931:3fbb with SMTP id
 a640c23a62f3a-c3190c21de7mr152857966b.2.1791446501129; Thu, 08 Oct 2026
 01:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927064434.3692113-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260927064434.3692113-1-nicoyip.dev@gmail.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 8 Oct 2026 16:01:29 +0800
X-Gm-Features: AclHuK_Lktj7p5BchFdW-xuICfCC3cq_YAKfmoW2RSWguLyK9_uNfG9-zdSUFUk
Message-ID: <CAAo+4rVktdBnFKfgJ5PjEQsXqHAJ=NuOXNyhJHQLkej+vGKVwg@mail.gmail.com>
Subject: Re: [PATCH net] rxrpc: Prevent reusing service connections marked for reaping
To: David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 2:45=E2=80=AFPM Chengfeng Ye <nicoyip.dev@gmail.com=
> wrote:
>
> The service connection reaper changes conn->active from 0 to -1 before
> unpublishing an idle connection. The I/O thread can have already found
> that connection and acquired an input reference. If it then allocates a
> new call, rxrpc_alloc_incoming_call() unconditionally increments
> conn->active, changing -1 back to 0. This violates the reaper's final
> assertion and can panic the kernel:
>
>   I/O thread                           Reaper
>   Look up conn and take input ref
>                                        Set active from 0 to -1
>   Allocate an incoming call
>     Increment active from -1 to 0
>                                        Assert active =3D=3D -1
>
> The kernel reported:
>
>   kernel BUG at net/rxrpc/conn_object.c:465!
>   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>   Workqueue: krxrpcd rxrpc_service_connection_reaper
>   RIP: 0010:rxrpc_service_connection_reaper+0x768/0xbc0
>   Call Trace:
>    process_one_work+0x5f2/0xf20
>    worker_thread+0x46e/0xda0
>    kthread+0x2b2/0x390
>    ret_from_fork+0x36e/0x5a0
>
> Use atomic_inc_unless_negative() before taking the call's connection
> reference. If reaping won the race, leave the activity count untouched
> and return through the existing BUSY rejection path without consuming a
> preallocated call. The caller's input reference keeps the connection
> live during this check. If call allocation wins, the positive activity
> count prevents the reaper from claiming the connection.
>
> Fixes: 3cec055c5695 ("rxrpc: Don't hold a ref for connection workqueue")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  net/rxrpc/call_accept.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
> index 47824120f1da..87bc3af2208b 100644
> --- a/net/rxrpc/call_accept.c
> +++ b/net/rxrpc/call_accept.c
> @@ -299,8 +299,9 @@ static struct rxrpc_call *rxrpc_alloc_incoming_call(s=
truct rxrpc_sock *rx,
>                 rxrpc_see_connection(conn, rxrpc_conn_see_new_service_con=
n);
>                 rxrpc_new_incoming_connection(rx, conn, sec, skb);
>         } else {
> +               if (!atomic_inc_unless_negative(&conn->active))
> +                       return NULL;
>                 rxrpc_get_connection(conn, rxrpc_conn_get_service_conn);
> -               atomic_inc(&conn->active);
>         }
>
>         /* And now we can allocate and set up a new call */
> --
> 2.43.0
>

Gentle ping on this patch. Any feedback would be appreciated.

Best regards,
Chengfeng
