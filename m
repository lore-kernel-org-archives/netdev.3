Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793033715;
	b=Dd3q9tIImz6dlS/dwckwuJziYN4YmnDhfxYRu72e3K/oY9pmrN/m2yROmoLKjsxbJG1t
	 /sXuBk1ObLlyK4kFWFu3zoTKPWjMFUHeJfxCDNuDpdKg+2hhFvHklkhiX+sFdSZfel9lH
	 GFg7svVyYZBfo7CReDcXPfS8sMAMtYoutOVIiw8DF3nLCEsC9ObHtw+yyPWk3yoTE1GjJ
	 czYwGaUIhPCY4VHBP3jkfmEcrJp19KwUX962ab6NSjY5C8uGnaYfT6QQeMICA32zSl89o
	 qtcyedJFTPmqJmW9S9giz7j7lxKhCwAwY0K01551EeEy/g/ByWiSLttTwG4dROrH78w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033715;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=5Ncfe7f40m4/oOnMLlmDO2VljgiOBDlSptMgbtqfgow=;
	b=aMA+x4hgsHLzMUS1EyWNWfofaSFVy2k+3p8+x0RL/i9TZTpEnc95sAOOWHz0QX2JkPYm
	 UX0VG8yH+dpHI5E8t8Xm42acyPy88OVmcDioH52Vx5RsZM50VwHL1Zr2BqZVaD86kJiwy
	 r6Zr6doWwR5WMIPLB6m6X4IbXTqxrmHd4TVMww0n/w2zgw3a2zuSa3IQ74X/9TAWjkYp3
	 k7LtOvQZDJfcTkSPh1jEspCfVLwegBgiJKb7XJqFPpJ0X9+Q3ZWw6NhzZiQaf/TsM4HZw
	 NWvZ5WHy0rEawo1pkZbhrNUcYunPn0tCi/3DHty5vAgWTpSCwykKEgq3yL6Y6HTM59w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SHW2vJaE;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=H5FYDCgr;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F68606A31D
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0F68606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SHW2vJaE;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=H5FYDCgr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793033713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ncfe7f40m4/oOnMLlmDO2VljgiOBDlSptMgbtqfgow=;
	b=SHW2vJaE8L72XFwSgZYJ3W/eXn5K43R8PjoUBNvveTtztnGStSRsYfKXkCYL/YSnp0lXbh
	8uIkRXUN4UAVcpJlGEE5khtn4hu+i3xbslxOVzitGP/Ho63d2vvj6X8ALgbV4oL/w4vHSn
	RMyHZ8AjzoW9kY8O0avgejBKutNEwbw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-Vm_1u_KhOfOGQqTya5qiSw-1; Mon, 26 Oct 2026 12:55:11 -0400
X-MC-Unique: Vm_1u_KhOfOGQqTya5qiSw-1
X-Mimecast-MFC-AGG-ID: Vm_1u_KhOfOGQqTya5qiSw_1793033711
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48dfa054f26so2793788f8f.2
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 09:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793033711; x=1793638511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Ncfe7f40m4/oOnMLlmDO2VljgiOBDlSptMgbtqfgow=;
        b=H5FYDCgrOLpHHY0fFZiBp1vY72aSIO8apIc2pPWbatVpT7yosRJKpcT8/VyYaF9WfF
         N3xbZJnzAX4JKvrmH0JIOR3XS/84Miqppmw4dHWDExrOXd53vIw2xBx4sLaiyj7RtiiL
         QlRnC4+HiKP4b63jooxapCVq/9NWq5r8dc1LIlALJPMlmcr+nV3FBpVooVOgLKe6eSpL
         UZJxIWnxwBfq+csBvEitWNMZ8+9eE5mjs+pMydmDoHsNwXYVCsqAqRohSzMKu43BgqZz
         wau46rzKd9NwwJfySl+zXrUU6nQVNTCIZmtpcCnU55xLVZZmZfM6g4dioDl6w8s+df45
         jqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793033711; x=1793638511;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Ncfe7f40m4/oOnMLlmDO2VljgiOBDlSptMgbtqfgow=;
        b=qgvcM1MwRqzIfill98u9p+Llb0XPNFJ/eVIf4q1Wz4FrUGIsL443LX1BDAJUNy4Y/X
         iOjvOtXV1gflLtKkxQVjUO0pzTQaq5xB4B8CWM7+UTS2ICsFNwW04f0nRBWU7e3TygRp
         W+GSuh6s1SXgt33ZFrnCsJ0yuaQ6oQyiXMeSVDtM5amqpjbOgum7f5xoS4PGwsiErD/x
         lfsHNAymuJVlrVTblFvCHGVXc9dtqybzSNhq62VRKRWwcHK9oUxLd9HNSsppb6TJlTqu
         qF+wQIlFBa0PvrBLL/wBu5oueZlFSLYqLxLIo8JGVHAPdv21/2Hzxy9Ea6AfkVyIVzJY
         3FPA==
X-Gm-Message-State: AFq9FYJorIz3aVZ68Hhxi2oMBsVEXPsw+hh2ISHhK2W4NEWmkzCR3jfA
	I4dzxkpbXKYibGo6I1uf61exMVdIO2b+02YnO9njKRKCHW6xBEnaMjJJ/7G39AGJlTZBxXNqxTW
	bQoxVcKOwTOsfi6JUf/wKdSiszyYekKL4OxubpP9KTKtsNm8/7ByVl+lqEg==
X-Gm-Gg: AYBFou0x/ubT594/tJfcsqIfxvUjzpeSlCFKu+FfBR81tEHdT4pkU/mU7K48wCOzg9t
	3Nx56nLdRUE1TkwbquKY5H9RWDCGZ9OJDz17CEpal+V4o+tNJ8KTbVgpa2cC6uR7RkQ6kR8Bosw
	zCaUCSZqeng0NV91PXJbfpCczPH6mQetOprGOjaSREmAj0KIU6bdpRf9aPXcQ8/PgFaxdH04Vb9
	kTar9kBhIkSX2SzpwUaBVc37DmgWrXwu+ad1AmQYQtOdTa0axI9O0NRK5yecK0XJJbIRgr4YGB4
	TUUnXz/KGy7QwN2e4o5CuXa3SIhM7FbsTpIGuZhdbdE/P+kBtZR7wZTkWYA8sjxA+9B2++iYtoN
	e584ZiijCxrhzPTV952eMp6TaTTthV12G+I+gp5L/Mb/iJ5M3bCyoQw==
X-Received: by 2002:a05:6000:2504:b0:48e:1421:ed49 with SMTP id ffacd0b85a97d-48e3eb75c9dmr15133866f8f.18.1793033710707;
        Mon, 26 Oct 2026 09:55:10 -0700 (PDT)
X-Received: by 2002:a05:6000:2504:b0:48e:1421:ed49 with SMTP id ffacd0b85a97d-48e3eb75c9dmr15133824f8f.18.1793033710329;
        Mon, 26 Oct 2026 09:55:10 -0700 (PDT)
Received: from debian (2a01cb0580324c0086a938fffe1eee25.ipv6.abo.wanadoo.fr. [2a01:cb05:8032:4c00:86a9:38ff:fe1e:ee25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdd5b3sm17359379f8f.53.2026.10.26.09.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:55:09 -0700 (PDT)
Date: Mon, 26 Oct 2026 17:55:07 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jchapman@katalix.com, tparkin@katalix.com
Subject: Re: [PATCH net] l2tp: only return sessions of the given tunnel in
 l2tp_session_get()
Message-ID: <at-F69h64Ineg2gp@debian>
References: <at8-2mFyrmPxfu29@debian>
 <20261026125702.3101778-1-hengyul@cs.unc.edu>
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
In-Reply-To: <20261026125702.3101778-1-hengyul@cs.unc.edu>

On Mon, Oct 26, 2026 at 08:57:02AM -0400, Hengyu Liang wrote:
> Hi Guillaume,
> 
> Thanks for looking at this.
> 
> I wasn't sure about the intended semantics. l2tp.rst says "L2TPv3
> session ids are unique across all tunnels", but it also says Linux
> allows the same ID in different tunnels, told apart by sk, and
> l2tp_session_register() still allows that for UDP encap.

My understanding is that L2TPv3 session IDs are unique across their
network namespace. There's an exception for those that are transported
over UDP, as they're now unique for a given UDP socket (the one of
their parent's tunnel).

As a result, looking up a UDP L2TPv3 session requires a socket and a
session ID. That works when demultiplexing an incomming packet, as we
have both information in this case. But that's a problem when selecting
a session from user space.

The correct approach would be to pass both a session ID and a socket
for any L2TPv3 UDP session lookup. But the netlink interface currently
doesn't support passing a socket fd for SESSION_GET, SESSION_MODIFY
and SESSION_DELETE operations. That could be done for managed tunnels
though.

However, for unmanaged tunnels, as used by iproute2, user space doesn't
know anything about the UDP socket. In that case, all we can do is to
replace the socket parameter with a tunnel ID. Then we'd have to loop
through all the sessions that match the requested session ID and return
the one whose tunnel's socket matches the socket of the tunnel ID
passed as parameter. This last operation could maybe be simplified to a
simple tunnel ID check, as, in my understanding, we have an 1:1
relationship between tunnel IDs and their sockets (but I'm a bit wary
of such shortcuts given that code have proved to be brittle in the past).

> The patch only changes callers of l2tp_session_get() that pass a
> tunnel_id, and the result differs from v6.8:
> 
>  - pppol2tp_connect() for session 5 in tunnel 2 fails with EEXIST if
>    tunnel 1 (another UDP socket) already has a connected session 5.
>  - "ip l2tp del session tunnel_id 4 session_id 7" deletes tunnel 3's
>    session 7 when only tunnel 3 has it. On v6.8 it fails. l2tp.rst
>    describes CONN_ID there as the parent tunnel of the session.
> Am I misreading the documentation, is the documentation out of date, or
> is this behaviour not intended?
> 
> Thanks,
> Hengyu
> 

