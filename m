Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793648379;
	b=LZMX9727V1NHKz5fQDED/vIKxb48tMGvZNysEWs9KPLdhHLSSkCvADLuyiNXEtVKQbtd
	 RxP5NRyp/VnI+e/E+XYF5BQV3/d2j4DkBnKeMzLHdPRZXkNVeKsDW6D2pgGSxYymzCRhk
	 eIv8oiQYts4IdMdGqhvaZB4rgottIBeWc0f7VYOFtL4FfuybHCuIWj0Qtr/7k9WrVKr62
	 LSmY5fuPc39zsUNQ7BMFwDQTb/tXtfD38UHcpQg/G2IeZuya7Ji13PxpDFrY2VpekmpPK
	 DM2ncOWgGumLNCcKcHQjjS1v8nTbedA3jNmIyf1VSjv7puJ6d22t+Tdam1yyh3ScjIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fILK0wI2UqUr5itU/0Cq58lsYc1ISo7g+t7NVEUk9BU=;
	b=3aVwVB/tuHYWAEarf0O9YRJYFvYP0y9fefh7FkNTo05lrbpSUkx3DCwNEpbrxqeZ6lXT
	 RF7Pxhz8Lqoqy14o7LD2P/Bva+qtCOJzLkdgJP4Ahc0bXr5bla3EYWZvCudshinWVZLPT
	 8K5z5vHCIET3Dqzt1DPU8PApWQUM24pOi33KgH6Zw/ITZ5HJX+oPjhDWYnRSBkhhzK2JF
	 h6nwLU91j3NLSt7kOejQshzqaiZ53KR7XJYsvwsY8DTHdfIpJoMwrr+G0tq1cWRC+J4yg
	 GRZjr4Y8gN3+n1K9Mb2cvMI+J9mvBZjOEUOTRWi+SJLqIMbUS8wfQUi/PuOgq4jplWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=NhlqvCEA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9897D606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9897D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=NhlqvCEA
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a60f90a924so1221717b3a.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:39:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793648378; cv=none;
        d=google.com; s=arc-20260327;
        b=qAUrs8IYgqmKzqWppWRjqN+XaYTuRm6OC6GGcl6a/EPHaCKQ3hJFgHjpWBM5LmIh7G
         fsYSlxYFH+IBdYsxyDgVd1xhhew+x1jtcT5QHq96sn3fBqGq02d3tnOvsZRlPsXWu7jJ
         QVqEWh7xqlqWw5IQrtcAcZmi4MrHyLZcYHIassQiRGY1NCC2HjMHnC1AX8eNmmHOsBFt
         KlBgSgQ+sRBJvPa5u44zOz7QD+xdOon7RG//TkOqxnJvugamfNnCwi8y844MGPPFeYXQ
         FKAliFK4J8kIJbxVQ5rLAFwFKtdLOEHgZk6fCZaTVZQmrrv01RHik/UpXNvTDFW0s8/v
         oA2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fILK0wI2UqUr5itU/0Cq58lsYc1ISo7g+t7NVEUk9BU=;
        fh=sf4BwMpXJgC+5mAKMDPb6QYPsq9DvrmEyOhnHavgU5o=;
        b=pBGLHnTcJQvMnfyaHYTBsfSuOpTUtHOWYY1N8JQ+VaY2szGb7FV3Iu8pp+RY+lZsXF
         Y4ZHND4kN3652YKSL8L3sH3KGznmB4ML9lxtpxqlwxNbZd6fzGbDnOPByaRwhTKI5PPF
         cHzVBa70GgGQj98yK2RcHb3LF3pujK1sDj/y/Gc8NHwZbv/9N3hQMDnBSxT74JBusqiW
         a0vl+gNDbzHTYKTs9EBxozq8YW0X5s3dJXgEeXT3S5+zDxsMHmvyBRCvexoeqJL8d3RB
         2aO6oQJdpfbG2NO1R/4FBrBjSvqfTcaWBBEJOff9s0SD46WV7dEiUmWwFbEa54D6rd09
         yqpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793648378; x=1794253178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fILK0wI2UqUr5itU/0Cq58lsYc1ISo7g+t7NVEUk9BU=;
        b=NhlqvCEAqNeQh82h66VjeQRCvmLs88bUiMN8vsKnqKJ9wOlSOkwk3pTRZNEo2Wk7dK
         HZv/BWl8uEe1rlLq4Esk4h0lNwnLc7ae2Ug4sIcT0bKI7VrNR03T1LZQUc4K6ZwzXmn6
         He3DDsns3zqXONgEkB7fjVVE0uQ4EfO58HLmbhylcYi+XV4OsEafFtSN66UNdGEqLvGf
         6+P0rp5Bbft2KMHvVeggiGD6wOnDjs5EEn+ovAV85fjamgZf+13AnKK26O49HqVD+JId
         Nx6Te9tI8mE+yrOdmnPFjh4Tt7FpFJqRk8cVNQb3naMOyfjmKyriiJkGVwtVtYKbw4fR
         FC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648378; x=1794253178;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fILK0wI2UqUr5itU/0Cq58lsYc1ISo7g+t7NVEUk9BU=;
        b=LVsQICTPEmnJg0XtdrWXiTyOrhxov5fOW14V4IPz6F6mo54k2contKc5cb0/MhbDyE
         nOAw+sGVeRgU10NHd+frms7zgh+bhdZIOJDsWF/gmTJv0vSlbuwhK6NkRG1EE8cJ/fep
         n/RU4+s7FnDyc5R14S5Yr9HBED4psLiSlfHz8x5xgKg2zQEqQeZWdjTn4LLIXjGOkq8l
         RBgTl3KFFS3WDXZsDaJugqXfrPjpErajDamVi8tLfeOxzwtvgt8HTtypx84/bQgHf7bS
         MIXVrBi4FU6xMeghlikZeXH7TvB4Ve/8rQMTsqfYB4drqO7Zjlp79noIv3KQBiZOFWOM
         NSWg==
X-Forwarded-Encrypted: i=1; AKwUvBwJY4dF5D31gP7QGl2TIsbDZdKnlnkg4qgYd762Er427h9dLhSUzz+p0rroD7hPOA1eUFQE+Kk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+s16cv7cbqjyE2UqRXnBm1dWOXtoFWT2Ai1Mt7sOg40r98DHof
	NblB6iMacdFwuC2fAynwlMCecruE29oPz5dMrdNK2sMF/MvrAC5EYvhHoxTrgwYXB1QFLkQbxJw
	zqQIvoG/Z7kMIroHwpEEyYFUUR9YlSXnF7RD7wMpy
X-Gm-Gg: AYBFou1YQ7S2e2j4ikZTP/wVgmRLmZw2UNgd8ZAsutNrVin+CNZY73SNSNFq3t5jIdH
	STTD5sCMgFcvZ/31Bocf1v5HUn8ol1s0MKjIqaXWNGs0aEvR+nahb1RVc3GZnv5SgfGG1kk0Rnt
	7ko8j3toj4yEHSIDPmFgU3WguGSRV0krI/EgXjN0LHp87oq4RIbvChYb/TAe2QAA68FwMJg3hSZ
	W19g9M5acDI7L1OxwNVEtCJoPEGY/ziXJrgmso5mXBLA9RPiHyoNT8+vSfSnrHcQVsdgDt+fS7/
	qvK5GEazVTESyWNf1sZSXa+7A8YMlcFtnXut/InIzutEPRlqPdV9+2cS5e5YtA0zQYzMzTKljiX
	YU07qjepv2WPAXLJVf8ZFPPRT2A2/vNU/a3Ce9JidY089JMSoLSHadqMCcchGo5WDZwcs
X-Received: by 2002:a05:6a00:3c89:b0:8a0:3307:c46c with SMTP id
 d2e1a72fcca58-8a9bea6b19cmr8445171b3a.36.1793648377853; Mon, 02 Nov 2026
 11:39:37 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102130540.252894-1-omosnacek@gmail.com> <CAEjxPJ4hxdvV-r8chmF3RAi9RJX=-4AqntG01=fWUhh4-xP+ew@mail.gmail.com>
In-Reply-To: <CAEjxPJ4hxdvV-r8chmF3RAi9RJX=-4AqntG01=fWUhh4-xP+ew@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 2 Nov 2026 14:39:25 -0500
X-Gm-Features: AclHuK_N7t88qS7YSGZ1TxDpP4hXHc3j5T0g0RysETh1DoLdW5UuZOpzEfeNB98
Message-ID: <CAHC9VhRU1WZrsnw4q+vA_pKGGPs6kydHZsLbycWzbN27ygLXdg@mail.gmail.com>
Subject: Re: [RFC PATCH] af_unix: introduce MSG_CMSG_SEALED
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	netdev@vger.kernel.org, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 10:14=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Nov 2, 2026 at 8:05=E2=80=AFAM Ondrej Mosn=C3=A1=C4=8Dek <omosnac=
ek@gmail.com> wrote:
> >
> > Currently, when a process receives a file through AF_UNIX's SCM_RIGHTS
> > mechanism, the security_file_receive() LSM hook is calledto allow LSMs
> > like SELinux to validate the receiver's access to the received file
> > (similarly to a process inheriting file descriptors through execve(2)).
> >
> > However, there are cases (such as dbus daemon/dbus-broker) where the
> > receiver doesn't intend to access the received file and merely wants to
> > forward it to a third process. In this case the forwarding process woul=
d
> > need to have the appropriate r/w access to the file in order to receive
> > it, even though it will never actually acess it. That leads to the
> > security policy having to grant the forwarder access to a potentially
> > wide range of files (in case of dbus-broker basically all files), which
> > is not ideal.
> >
> > This patch adds a new CMSG flag MSG_CMSG_SEALED that, when passed to
> > recvmsg(2), wraps any received files into an opaque anonymous inode wit=
h
> > the name "[envelope]", skipping the security_file_receive() LSM check.
> > The returned "[envelope]" file descriptor can't be used in any
> > meaningful way other than being passed forward via sendmsg(2) with the
> > MSG_CMSG_SEALED flag. In that case the original file is unwrapped and
> > sent via SCM_RIGHTS to the receiver. The receiver can then either
> > receive the file as normal (subject to the LSM check) or again "sealed"
> > in the "[envelope]" anon inode for further forwarding.
> >
> > Note that sending the "[envelope]" file is only allowed with the
> > MSG_CMSG_SEALED flag set, to make the unsealing explicit and avoid
> > unexpected behavior. Attempting to send it without this flag will fail
> > with an error. This also avoids recursive nesting of "[envelope]" files=
,
> > which would only make this feature harder to audit for possible issues.
> >
> > This patch also adds a simple read-only sockopt for UNIX sockets that
> > allows userspace to determine if this feature is present (passing
> > unknown CMSG flags unfortunately doesn't lead to an error currently).
> > The minimal code to do so can look like this:
> >
> >     #ifndef SO_RIGHTS_SEALED_SUPPORTED
> >     #define SO_RIGHTS_SEALED_SUPPORTED 88
> >     #endif
> >
> >     #include <sys/socket.h>
> >     #include <unistd.h>
> >     #include <stdbool.h>
> >
> >     bool MSG_CMSG_SEALED_supported(void)
> >     {
> >         int sock, ret;
> >         socklen_t optlen =3D 0;
> >
> >         sock =3D socket(AF_UNIX, SOCK_STREAM, 0);
> >         if (sock < 0) {
> >             /* handle error */
> >             /* ... */
> >         }
> >
> >         ret =3D getsockopt(sock, SOL_SOCKET, SO_RIGHTS_SEALED_SUPPORTED=
,
> >                          NULL, &optlen);
> >         close(sock);
> >
> >         return ret =3D=3D 0;
> >     }
> >
> > Related: https://github.com/fedora-selinux/selinux-policy/issues/3286
> > Related: https://github.com/fedora-selinux/selinux-policy/issues/3287
> > Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> > ---
>
> > diff --git a/net/core/scm.c b/net/core/scm.c
> > index ae38f3c1165c..08822b2a1f22 100644
> > --- a/net/core/scm.c
> > +++ b/net/core/scm.c
> > @@ -114,10 +127,29 @@ static int scm_fp_copy(struct cmsghdr *cmsg, stru=
ct scm_fp_list **fplp)
> >
> >                 if (fd < 0 || !(file =3D fget_raw(fd)))
> >                         return -EBADF;
> > -               /* don't allow io_uring files */
> > -               if (io_is_uring_fops(file)) {
> > -                       fput(file);
> > -                       return -EINVAL;
> > +
> > +               if (sealed) {
> > +                       /* Only allow sealed files */
> > +                       if (file->f_op !=3D &envelope_ops)
> > +                               return -EINVAL;
>
> This leaks a file reference.
>
> > +
> > +                       file =3D (struct file *)file->private_data;
>
> This fails to take a reference to the underlying file but will later get =
fput().
>
> > +
> > +                       /*
> > +                        * No need to check for io_uring files here as =
the
> > +                        * underlying file had already successfully pas=
sed the
> > +                        * check when it was first sent.
> > +                        */
> > +               } else {
> > +                       /* Don't allow sealed files */
> > +                       if (file->f_op =3D=3D &envelope_ops)
> > +                               return -EINVAL;
>
> This also leaks a file reference.
>
> > @@ -365,18 +398,37 @@ static int scm_max_fds(struct msghdr *msg)
> >  }
> >
> >  int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flag=
s,
> > -                   bool notrunc)
> > +                   bool notrunc, bool sealed)
> >  {
> > +       struct file *f_received;
> >         int error;
> >
> >         if (!ufd)
> >                 return -EFAULT;
> >
> > -       error =3D security_file_receive(f);
> > -       if (error)
> > -               return notrunc ? put_user(error, ufd) : error;
>
> Design point: I would suggest adding and using a new LSM hook that
> allows security modules (like SELinux) to still be able to check a
> (new) permission that governs whether a process can pass along these
> sealed fds so that we do not entirely lose control over their use.

I've only given this a quick look, but I'm also not excited about the
LSM hook being conditional on the "sealed" flag.  I'd prefer for the
security_file_receive() hook to catch all the files, but take an
additional bool argument indicating the sealed state; this would allow
individual LSMs to decide how best to handle this.

  security_file_receive(struct file *file, bool sealed)

--=20
paul-moore.com
