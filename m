Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262823F8252;
	Wed, 26 Aug 2026 11:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787745589; cv=none; b=GYmG7ZszYR18eoi6VSGAaCCzQXRWVro1eIw9cHClF3QNS0wkSZi22JqzccopIBP+WCkrO/C7E0DNR7f64UzY7zACONdqil1STtflqYzKJ1GVTZyD5CKk/l1xDmss5DAF+fnLbulsxTZ5OjrEYegEFguQ06P+O60/mihY+mvycRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787745589; c=relaxed/simple;
	bh=V/wrOBXnzfXwO7qi8GOTgQOydrkFkmTSVS54L1hsMy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Se8vH0pRhLff2eQL/kvqGxKoQxXvXADDoEuI7ogRQ0xStDd+UARx2kSFNfMNw18XC6mZ+1nkk2rczMMhOVgn9Gy9qWuAcMAojOvYK+e6OFrC9qSDmL2skVKFZkgMp3RvODSXhiVwLh8pxFVI5sEyv6eZRlYaT9ezdavOzLOfZ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2H4IMGB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2H4IMGB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37221F00A3A;
	Wed, 26 Aug 2026 11:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787745587;
	bh=AkbV1zaOyzETWRzzrYrZyf5g3bogiqrirAZC/gk6t4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y2H4IMGBu/szxPHdQGSXXeVxxSywaLoXM2MrMTtyfZrGWXpc2UTRe49Qs47ACdqJZ
	 pO1TMjDRL/zEgOW5SG/n1jcNS+7otSPONdnjgEYzQqC0Idk0vUk/x8RBA+kbUrp+p+
	 vuTvhbudVYO2exiEotTPZraDdsNhfVpBE9fEm6NdLDCBQb038x+Fo5h8QyI/w8/3qo
	 RL/vnDuuithvGBF516uUxWSin3Pu0vvcetfV76xAehPQISUb1js/UTBF6sc6FGtv5W
	 2aFG2JqwOHC9DvgcSZn3eaGITvuDeO8H4RrufOEFkTirn9Jtrpgb4WCUApVLyvESXh
	 RQVT3UQuIRsRA==
From: Simon Horman <horms@kernel.org>
To: kartikey406@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	3chas3@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+6665d3db5fef15914802@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: atm: fix shift-out-of-bounds in __vcc_connect()
Date: Wed, 26 Aug 2026 12:59:27 +0100
Message-ID: <20260826115927.343690-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824024620.23485-1-kartikey406@gmail.com>
References: <20260824024620.23485-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824024620.23485-1-kartikey406@gmail.com?part=1
---
net: atm: fix shift-out-of-bounds in __vcc_connect()

__vcc_connect() used dev->ci_range.vpi_bits and vci_bits directly as shift
amounts, which is a negative shift when those fields still hold the
ATM_CI_MAX (-1) sentinel.  The patch skips the VPI/VCI range check
entirely when either field equals ATM_CI_MAX.

Closes: https://syzkaller.appspot.com/bug?extid=6665d3db5fef15914802

> diff --git a/net/atm/common.c b/net/atm/common.c
> index 81195727fa18b..b38359453555b 100644
> --- a/net/atm/common.c
> +++ b/net/atm/common.c
> @@ -378,8 +378,11 @@ static int __vcc_connect(struct atm_vcc *vcc, struct atm_dev *dev, short vpi,
>  	int error;
>  
>  	if ((vpi != ATM_VPI_UNSPEC && vpi != ATM_VPI_ANY &&
> +	    dev->ci_range.vpi_bits != ATM_CI_MAX &&
>  	    vpi >> dev->ci_range.vpi_bits) || (vci != ATM_VCI_UNSPEC &&
> -	    vci != ATM_VCI_ANY && vci >> dev->ci_range.vci_bits))
> +	    vci != ATM_VCI_ANY &&
> +	    dev->ci_range.vci_bits != ATM_CI_MAX &&
> +	    vci >> dev->ci_range.vci_bits))
>  		return -EINVAL;

[Severity: High]
This isn't a bug introduced by this patch, but does the same negative shift
remain reachable from the function being modified here?  find_ci() is
called by __vcc_connect() a few lines below:

net/atm/common.c:__vcc_connect() {
	...
	if (test_bit(ATM_DF_REMOVED, &dev->flags) ||
	    (error = find_ci(vcc, &vpi, &vci))) {
	...
}

and find_ci() shifts by the same fields with no sentinel check:

net/atm/common.c:find_ci() {
	...
	else if (p >= 1 << vcc->dev->ci_range.vpi_bits)
		p = 0;
	if (*vci != ATM_VCI_ANY)
		c = *vci;
	else if (c < ATM_NOT_RSV_VCI || c >= 1 << vcc->dev->ci_range.vci_bits)
			c = ATM_NOT_RSV_VCI;
	...
		if (*vci == ATM_VCI_ANY) {
			c++;
			if (c >= 1 << vcc->dev->ci_range.vci_bits)
				c = ATM_NOT_RSV_VCI;
		}
	...
			p++;
			if (p >= 1 << vcc->dev->ci_range.vpi_bits)
				p = 0;
	...
}

Note the new guards in __vcc_connect() are skipped when vpi is ATM_VPI_ANY
or vci is ATM_VCI_ANY (both -1 in include/uapi/linux/atm.h), which is
exactly the case that then reaches find_ci().  pvc_bind() passes the
userspace sockaddr_atmpvc values through vcc_connect() unchanged, and
vcc_connect() only rejects !(vpi || vci):

net/atm/pvc.c:pvc_bind() {
	...
	error = vcc_connect(sock, addr->sap_addr.itf, addr->sap_addr.vpi,
			    addr->sap_addr.vci);
	...
}

On a device that leaves the sentinel in place, e.g. usbatm_atm_init():

drivers/usb/atm/usbatm.c:usbatm_atm_init() {
	...
	atm_dev->ci_range.vpi_bits = ATM_CI_MAX;
	atm_dev->ci_range.vci_bits = ATM_CI_MAX;
	...
}

wouldn't a bind() with sap_addr.vpi or sap_addr.vci set to -1 still produce
the same "shift exponent -1 is negative" report, only from find_ci()
instead of __vcc_connect()?  With panic_on_warn set, ubsan_epilogue()
calls check_panic_on_warn("UBSAN"), so this would still be a panic.

There also looks to be a secondary effect: since 1 << -1 folds to INT_MIN
on architectures that mask the shift count, both p >= 1 << vpi_bits and
c >= 1 << vci_bits are always true, so after the first wildcard VCC is
allocated the do/while scan in find_ci() hits old_p == p && old_c == c on
the first iteration and returns -EADDRINUSE.  Does that make a second
automatically-allocated VC impossible on such a device?

Would it be preferable to resolve the sentinel to a real bit width once,
so both __vcc_connect() and find_ci() see a sane value?

[Severity: Medium]
Separately, is skipping the check the intended reading of the sentinel?
The uAPI describes it as the maximum range rather than as unrestricted:

include/uapi/linux/atmdev.h:
#define ATM_CI_MAX      -1              /* use maximum range of VPI/VCI */

struct atm_cirange {
	signed char	vpi_bits;	/* 1..8, ATM_CI_MAX (-1) for maximum */
	signed char	vci_bits;	/* 1..16, ATM_CI_MAX (-1) for maximum */
};

with the maxima defined in include/uapi/linux/atm.h as ATM_MAX_VPI 255 and
ATM_MAX_VCI 65535.  The commit message says:

  "Skip the range check when ci_range.vpi_bits/vci_bits is still
  ATM_CI_MAX, since that value means "unrestricted"."

Should this instead clamp to 8/16 bits (or compare against ATM_MAX_VPI /
ATM_MAX_VCI) and keep the check?

This also appears to change behaviour for negative identifiers other than
the ANY/UNSPEC magic values.  Before the patch, vpi >> -1 folded to
vpi >> 31 on architectures that mask the shift count, which is -1 for a
negative vpi and therefore returned -EINVAL.  After the patch a bind() with
sap_addr.vpi = -5 or sap_addr.vci = -65531 is accepted, since vcc_connect()
only rejects !(vpi || vci) and check_ci() masks vci purely for hashing:

net/atm/common.c:check_ci() {
	struct hlist_head *head = &vcc_hash[vci & (VCC_HTABLE_SIZE - 1)];
	...
}

The raw value then reaches vcc->vpi/vcc->vci and dev->ops->open().
usbatm_atm_open() does not bound them, and usbatm_write_cells() packs them
into the fixed-width cell header without masking:

drivers/usb/atm/usbatm.c:usbatm_write_cells() {
	...
	ptr[0] = vcc->vpi >> 4;
	ptr[1] = (vcc->vpi << 4) | (vcc->vci >> 12);
	ptr[2] = vcc->vci >> 4;
	ptr[3] = vcc->vci << 4;
	...
}

Can this alias distinct VCCs onto the same on-the-wire VPI/VCI, for example
vci = -65531 and vci = 65541 both transmitting on reserved VCI 5, while
the check

	if (vci > 0 && vci < ATM_NOT_RSV_VCI && !capable(CAP_NET_BIND_SERVICE))
		return -EPERM;

is evaluated on the untruncated value and so does not fire?  The duplicate
detection in check_ci() compares the untruncated values too, so it would
not catch the collision either.
