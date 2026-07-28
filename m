Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED86340D565
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785232240; cv=none; b=t1J+IZtWCD7rOljFsmHeKk6D3wb2Phf+SWHL5k5K2GSo0L+W/nQvZLKOIC72hbVsalruO3OK7C5LAY8CuxZgFrlQxxzXPORqGdaZDAq2Ft67RtoHB0Alh0tKxZlPJ46h02o/d0iHaBQHbOmrcxAJeWYWI+IvAR7J7FIkZ0uhkwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785232240; c=relaxed/simple;
	bh=iKkwr8V1PuRndsb7cgQEaiCzyGc93W31tew9oyt9XRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kdHL9hF7c3mvP2ElKLWGQic/SaDKmb1QvLJqmW4KqI7kCpICGTNOMHg87i0QFkKxvrN/4FW5FGhnaa7Qs6y22uwYIcg6CACX66NJR+AAV5H9ncLkxgDXKmpCleX/+7pcaRbt2Beq1lMVOOEA7QXhhqjp8dHpd7v9oClJNRIgd9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QINi/yuO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k+8oujNo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QINi/yuO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="k+8oujNo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785232238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4+dMiX263jf+8Bae1dw+OAYWda9quJsqvCsepo8Mcbw=;
	b=QINi/yuOeQ4YjHdONhA3gnVXnQz4GdxO7CrVuEJV7eoem14Z9rZ2w8MncJzDhlIVtso4Bl
	bNC993TQTWHLQpEl7LhtMFK5viof3BEVh/8dHui9o7fV9nbs6xu8G4FtqmA0W2G9qGg5lK
	0iDK5TPKQt77424oQdCgshsGwe1VY3k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-U3gQogMhPrC5gMWrzVM_Aw-1; Tue, 28 Jul 2026 05:50:34 -0400
X-MC-Unique: U3gQogMhPrC5gMWrzVM_Aw-1
X-Mimecast-MFC-AGG-ID: U3gQogMhPrC5gMWrzVM_Aw_1785232233
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4955ecd8a10so32793965e9.3
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 02:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785232233; x=1785837033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4+dMiX263jf+8Bae1dw+OAYWda9quJsqvCsepo8Mcbw=;
        b=k+8oujNoLEROoaRR3jBfX3MR01Ht/jvp4grpYKdNO8Sp36kr/bhixjr08vZIu0VdUS
         Y4WOj1Lf4TZfZn4AJbTfb2hScQTaE99ef1PaQbvyQ0bIRLTtzpz9rEtZGy+2wtzD9P11
         HU5qPPalJp/LtYY7qjyU+ulpHfIOcHR5XGht2ImsVnmBEFjR/za2NAt7WQFvUfgaj+N+
         kvVU6jGHLMhxL1NdBgQ67bUfzW1AvyoRL3i34NpcXxVOeErU8UgvwxFyOTvqnxuza9FT
         qCQDT0+fVtUA6qOmEOKVq7mB22v1YqmgAJgiusR97NTQqrNpyKvvY3M3aq/MtVm/qNrW
         fznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785232233; x=1785837033;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4+dMiX263jf+8Bae1dw+OAYWda9quJsqvCsepo8Mcbw=;
        b=Yv0y85n9Q7uPgdPdHO3yILjp8MF/4p4gAqmLydQwpMsW4Ynu1/yazfI/dr6sc6C57t
         amNezml6EgJkoNnNw+kc8swB97pjsOO6p2eiAmDIN6aWLwYQOF6VGYrY5uJ+1VUC/nuL
         6U63PdqIo7CToXEHWi/JwyFOgDEceVsH/QD9Nc3pFAaPPiH9XjKH4UXhCjdSTy2IkTTZ
         910D2t4hnyl4anMFhiM2jdHjMb/IR6AItZ5ezRa4GCr6JW8Ap++tCd1jP7z2+K0OcD35
         pFkmyAYfWlpYzFBBbETLcJdFZ0C4Xei8XaNlFWej3eHOm7AWO8eaadKZVXTTC+RkG5eu
         wE/w==
X-Forwarded-Encrypted: i=1; AHgh+RqK6eEK3qm1vwHmLsgmNFHki7QMdSmBRbQBRBX3LwK61IWhRQ02AVttls/XQXqGf+lp/gerHlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Mpm8NoNjAlEu5AHIkwR/9OHB2kBE5wN+V9EuM+u72OyPKTgj
	FAFkvU1BwOTr1vKFcTHmAsG1d6hUeLAqli4zUsNgj2R04G9Cb5m4yw60PG4I9IQ57Pfcpl76ujU
	OvKNg58B/KAZpN29vgsoqUuPTBfkYly3OF74FCtQ7doaaJsH/pw3YIr1b5A==
X-Gm-Gg: AR+sD11pckqZvI+k/uuV7q1pJHBMuvpophjnQ5Ix3P+t/nkWq+FmT24kcVWRE9rndy1
	PzbmRWDsYKrviedjruh0JSI0RSKcgGNuYIchkpXmrAEsdf6UaZk+YGyoyJ2wuMzPR2VVOzFyTvs
	445gFDusG/u+YS+1ZNPsEMauyLPKBIY+93XmIkC0npP8HY3MHkA/4irEOitxUkngNJw/zEvZBDQ
	COendpF6Gx8lU4zDxV8gdj6Dc/2hAtYEKwL+ALdu7MGo7ymxV7VPDU5/KhFSsoJ6HkE+G7frrme
	zajIEnekdqmh9pj21o7xpxBbSthWXoIrQkcYybRvh58EV1J7BDDPHeUBy75MVvTbT3fV0HuC50X
	bYppOE0oj7sWXSxdgmbpqv4QiD3TZMoTntFrGaJpU5/ZJ9ymWRBRcTeG8JSiiqdoovEP86C0CXW
	du6w==
X-Received: by 2002:a05:600c:8214:b0:495:5cda:52ec with SMTP id 5b1f17b1804b1-496c643b0f5mr17224465e9.16.1785232233339;
        Tue, 28 Jul 2026 02:50:33 -0700 (PDT)
X-Received: by 2002:a05:600c:8214:b0:495:5cda:52ec with SMTP id 5b1f17b1804b1-496c643b0f5mr17224185e9.16.1785232232921;
        Tue, 28 Jul 2026 02:50:32 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c531afsm63156402f8f.24.2026.07.28.02.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 02:50:32 -0700 (PDT)
Message-ID: <e9709a13-9fd9-4ee3-88b0-9cc56a1ca07c@redhat.com>
Date: Tue, 28 Jul 2026 11:50:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/3] af_unix: Schedule the garbage collector
 at task exit
To: Nam Cao <namcao@linutronix.de>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <cover.1784712370.git.namcao@linutronix.de>
 <ba4ed2717e5225b7b77ef928fb97ee5544632811.1784712370.git.namcao@linutronix.de>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <ba4ed2717e5225b7b77ef928fb97ee5544632811.1784712370.git.namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/26 11:31 AM, Nam Cao wrote:
> When a task exits while still having dead cyclic reference AF_UNIX sockets,
> those sockets stay behind indefinitely until the garbage collector gets
> scheduled by an unrelated reason. This can be observed with the program
> below.
> 
> Resolve this issue by scheduling the garbage collector during task exit,
> after the task's file descriptors have been closed.
> 
>  #include <sys/mount.h>
>  #include <sys/socket.h>
>  #include <sys/un.h>
>  #include <sys/wait.h>
> 
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> 
> static int send_fd(int unix_fd, int fd)
> {
>         struct msghdr msgh;
>         struct cmsghdr *cmsg;
>         char buf[CMSG_SPACE(sizeof(fd))];
> 
>         memset(&msgh, 0, sizeof(msgh));
> 
>         memset(buf, 0, sizeof(buf));
>         msgh.msg_control = buf;
>         msgh.msg_controllen = sizeof(buf);
> 
>         cmsg = CMSG_FIRSTHDR(&msgh);
>         cmsg->cmsg_len = CMSG_LEN(sizeof(fd));
>         cmsg->cmsg_level = SOL_SOCKET;
>         cmsg->cmsg_type = SCM_RIGHTS;
> 
>         msgh.msg_controllen = cmsg->cmsg_len;
> 
>         memcpy(CMSG_DATA(cmsg), &fd, sizeof(fd));
>         return sendmsg(unix_fd, &msgh, 0);
> }
> 
> int main(int argc, char *argv[])
> {
> 	int fd[2];
> 	int i;
> 
> 	for (int n = 0; n < 100; ++n) {
> 		if (socketpair(PF_UNIX, SOCK_SEQPACKET, 0, fd) == -1)
> 			goto out_error;
> 
> 		for (i = 0; i < 100; ++i) {
> 			if (send_fd(fd[0], fd[0]) == -1)
> 				goto out_error;
> 
> 			if (send_fd(fd[1], fd[1]) == -1)
> 				goto out_error;
> 		}
> 	}
> 
> 	return 0;
> 
> out_error:
> 	fprintf(stderr, "error: %s\n", strerror(errno));
> }
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  include/net/af_unix.h | 5 +++++
>  kernel/exit.c         | 7 +++++++
>  net/unix/af_unix.h    | 1 -
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index 34f53dde65ce..686f6f1d1c21 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -14,11 +14,16 @@
>  
>  #if IS_ENABLED(CONFIG_UNIX)
>  struct unix_sock *unix_get_socket(struct file *filp);
> +void unix_schedule_gc(struct user_struct *user);
>  #else
>  static inline struct unix_sock *unix_get_socket(struct file *filp)
>  {
>  	return NULL;
>  }
> +
> +static inline void unix_schedule_gc(struct user_struct *user)
> +{
> +}
>  #endif
>  
>  struct unix_address {
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 2c0b1c02920f..593ac4b0105f 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -71,6 +71,7 @@
>  #include <linux/unwind_deferred.h>
>  #include <linux/uaccess.h>
>  #include <linux/pidfs.h>
> +#include <net/af_unix.h>
>  
>  #include <uapi/linux/wait.h>
>  
> @@ -1009,6 +1010,12 @@ void __noreturn do_exit(long code)
>  	exit_task_work(tsk);
>  	exit_thread(tsk);
>  
> +	/*
> +	 * Must be after exit_files() and exit_task_work(tsk) to ensure that
> +	 * the task's AF_UNIX sockets have all been closed.
> +	 */
> +	unix_schedule_gc(NULL);

Sashiko noted this can cause relevant regressions:

https://sashiko.dev/#/patchset/cover.1784712370.git.namcao%40linutronix.de

Generally speaking hooking the unix GC at task exit time does not feel
right (layering violation). Perhaps scheduling the GC with a reasonable
timeout in unix_update_graph() would be better?

/P

