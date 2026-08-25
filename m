Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE3038736E;
	Tue, 25 Aug 2026 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648483; cv=none; b=MjT5O3yzQelJ5U7dNNzcBqoTQqxxExt3kNpuJC3S6EsBobm2OVHRtw1fpj3C/JAo7cWOrYgyStUKbKi/gQ4xelZPZrOiRr7rVi+f3CWGN04dLniGrQlt72pqiKgsz4rlmvUGi77wJELT+5BY75HRcTolmd2+ununL7iLoampT70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648483; c=relaxed/simple;
	bh=EtIg01LaNBNQflNfivlxVDBqFs5XWLOUiWj6zEAukhc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=aWjDsUWaiMV+PxSbHVzkqAibsvTEBLftdRibetJMAEckzyuCH6qlCc0/gY25k/bD28a1Kja8G++XdS8keCMLe1+RvTPtYPwG0sK3VaGnS6k/AuRKWopeLSetdQ4wpkiCLuvpnIowFLQACyGX8EFd6R61O1ITDRkLyn5A22rCPkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hvaJ7GWN; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hvaJ7GWN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787648470; bh=rKGz4VrG3l8VTDavSuZn0tyxha5an2wdcen9Us3BOqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hvaJ7GWN10+tf5uzlnXIpz/rqrfSuWyEw/7vsWcgo80iLUo2DlUd+RmLp7BoNnF6+
	 /FJA6YqBNn3sC29cQAB1ruLyjMRBamZQ6QIs0jPJJJqGhrxK2pqkzbhouczxijLBxf
	 UIKNnfrHg93LzcglykuXNy2evV+4EhhNSiTonDl8=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 463F8B6; Tue, 25 Aug 2026 17:01:06 +0800
X-QQ-mid: xmsmtpt1787648466trukzz202
Message-ID: <tencent_F7A4E81EEE16CD5078266CFC2E396F8C940A@qq.com>
X-QQ-XMAILINFO: MZtEYADUG4AgUxCqNVx+p6rrNQXn7KDRIyfn7WizF4Qu3k7XsXj0VypnH+kL23
	 2T4aDDzHXZ55gpOTxi9Tagagp8WEuy0n0jJ5IoLnbPCnJTzl0w9nfT+DfxB4wYpVIRIxJrzvl02x
	 RVzGGiDjIk5xHxPKyhLNNGB05NqYzhlpHsmQPEfZSS0ChIMZmMRC3F3K0ijWdixQ7kv0INeRTSRs
	 OjlACWv0A3+HguGc5ySIsmLLW6UIGveynyTadrwrZZfO4TUwwxgXft/fGH9cje6CmIq0StPtZmbR
	 vn1vc2FWtadsS+Glvwx4aP3oHug+AjuOXOjkGs4AUwzgtFB2qFakTENtMqudzgkGTzafndsDAuco
	 PmsG/3WqfwNM5d2/5vSDl2t147BV3E54SV0PyEaJz53B11tp0/J5tJyidC2qoLSV1459Y/nFKQG1
	 8QyoSz6jcHP72PChieWX16fVnTG5q+TDghHkG/Sey9gLM+fDNm1z/pRA0tmy4X3tUFP9exAghjfe
	 pp4+wQEMZVBZ00IT/M3jtK9LoJTL2LDahAjM+AtxjpTzbB+rjnyoHw8G43NeP78MzTwPdlp7okVc
	 gPeUEnLFvp3+zZy0V9eFEZl0m/kgbIiPsbGgdw7hcno7YfwdP4xy4JujUauR9arrjvyas5H4Na/B
	 PNV9iAwaxUjUPVh+8w6a36i4FZSyZtPFtXTp9JJIrtbwnGbAWOhGHJ7bSd01uWes5+zWvDDfFHjO
	 vpQcMh82TQJhdU4VCfltd3Oy4slBUKKcPFjiEn7BkLgkfJSSRdUDCNkBQdIki3erzzppJ0vlameJ
	 LE0CBrYeNqAE/84MsPa7deFF2Jx8WxHk4mtr+pZfnPBi3oykkT/2dq2ezD+deV7ZMdeS/gffa0QX
	 OmRJFuoqss/wibm9ihVQMA0DYqkbKXc9lvB63b01RCB0eLWgBHotbBUV/3hhvDi2pkN/w4RolGCS
	 qRpJHcqCpLVZF/Rb6ztbkvsx+JLhUIFW8SkVxGWqaxzoRj50+7Fn1L39tM3KAW+ZWJzmy0RJBdeX
	 KXwPpwLPlalbxLpvbw
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Edward Adam Davis <eadavis@qq.com>
To: jhs@mojatatu.com
Cc: Po.Liu@nxp.com,
	davem@davemloft.net,
	eadavis@qq.com,
	edumazet@google.com,
	horms@kernel.org,
	jiri@resnulli.us,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v2] net/sched: act_gate: Limit the max value for cycletime
Date: Tue, 25 Aug 2026 17:01:06 +0800
X-OQ-MSGID: <20260825090105.48266-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAM0EoMmHMFQ+mATPoHv-5uyN9++Lch7MDjHsC7eu=NVapRB2bQ@mail.gmail.com>
References: <CAM0EoMmHMFQ+mATPoHv-5uyN9++Lch7MDjHsC7eu=NVapRB2bQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 25 Aug 2026 04:25:04 -0400, Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> On Sun, Aug 23, 2026 at 12:07 AM Edward Adam Davis <eadavis@qq.com> wrote:
> >
> > If the user passes a cycletime value of 0xFFFFFFFFFFFFFFFFULL,
> > an overflow occurs during the assignment of cycle in gate_timer_func():
> >
> > cycle = p->tcfg_cycletime; // overflow, cycle = -1
> >
> > Since the local variable cycle is declared as ktime_t (i.e., s64),
> > the assignment overflows.
> >
> 
> Review the sashiko feedback. At least two of those concerns look legit
> and need to be addressed:
> 1) complaint about timer disarm on replace 2) INT_MAX being too narrow
I haven't received any feedback regarding sashiko, and I didn't quite
understand the points made in item 1); could you please provide more
details?

Regarding item 2), if INT_MAX is too narrow, do you have a suitable value
to recommend? S64_MAX?

cheers,
Edward

